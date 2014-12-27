###
# Modules
###
_           = require('lodash')
gulp        = require('gulp')
clean       = require('gulp-rimraf')
cjsx        = require('gulp-cjsx')
concat      = require('gulp-concat')
enviro      = require('gulp-env')
filter      = require('gulp-filter')
iif         = require('gulp-if')
imagemin    = require('gulp-imagemin')
jade        = require('gulp-jade')
minify      = require('gulp-minify-css')
plumber     = require('gulp-plumber')
rename      = require('gulp-rename')
sass        = require('gulp-ruby-sass')
supervisor  = require('gulp-supervisor')
uglify      = require('gulp-uglify')
sync        = require('browser-sync')

{ exec, spawn } = require('child_process')
key = require('./key.json')
env = require('./env.json')
data = _.extend({}, (key or {}), env)


###
# Directory Paths
###
_src = './src'
_build = './_build'
d =
  modules: './node_modules'
  src:
    html: "#{_src}/frontend/html"
    js: "#{_src}/frontend/js"
    css: "#{_src}/frontend/css"
    img: "#{_src}/frontend/img"
    misc: "#{_src}/frontend/misc"
    vendor: "#{_src}/frontend/vendor"
    backend: "#{_src}/backend"
    shared: "#{_src}/shared"
  build:
    public: "#{_build}/public"
    js: "#{_build}/public/js"
    css: "#{_build}/public/css"
    img: "#{_build}/public/img"
    vendor:
      js: "#{_build}/public/js/vendor"
      css: "#{_build}/public/css/vendor"

###
# Tasker
###
_do = (src='', dest='', task='', filename='') ->
  _copy = task is ''
  _sass = /sass/.test task
  _jade = /jade/.test task
  _coffee = /coffee|cjsx/.test task
  _uglify = /uglify/.test task
  _minify = /minify/.test task
  _imagemin = /imagemin/.test task
  _rename = /rename/.test task
  _dev = /dev/.test task

  if _sass
    sass(src, {compass: true, style: 'compressed', sourcemap: false}) # Sass
      .pipe(do plumber) # Plumber
      .pipe(gulp.dest(dest)) # Destination
      .pipe(filter('**/*.css')) # Filter CSS
      .pipe(sync.reload(stream: true)) # BrowserSync
  else
    gulp.src(src)
      .pipe(do plumber) # Plumber
      .pipe(iif(_jade, jade({data, pretty: true}))) # Jade
      .pipe(iif(_coffee, cjsx(bare: true))) # Coffee/React
      .pipe(iif(_uglify and not _dev, uglify(compress: drop_debugger: false))) # Uglify
      .pipe(iif(_minify and not _dev, minify())) # Minify
      .pipe(iif(_imagemin and not _dev, imagemin(progressive: true))) # Imagemin
      .pipe(iif(_rename and !!filename, rename(basename: filename))) # Rename
      .pipe(gulp.dest(dest)) # Destination
      .pipe(iif(_copy, sync.reload(stream: true))) # BrowserSync


###
# Clean
###
gulp.task 'clean', ->
  gulp.src(_build, {read: false}).pipe(clean())
gulp.task 'clean:modules', ['clean'], ->
  gulp.src(d.modules, {read: false}).pipe(clean())
  gulp.src(d.src.vendor, {read: false}).pipe(clean())

gulp.task 'clean:all', ['clean', 'clean:modules']


###
# Vendor Files
###
gulp.task 'vendor', ->
  _do("#{d.src.vendor}/requirejs/require.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/zepto/zepto.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/lodash/dist/lodash.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/q/q.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/react/react-with-addons.js", d.build.vendor.js, 'uglify rename', 'react')
  _do("#{d.src.vendor}/flux/dist/Flux.js", d.build.vendor.js, 'uglify rename', 'flux')
  _do("#{d.src.vendor}/page/index.js", d.build.vendor.js, 'uglify rename', 'page')
  _do("#{d.src.vendor}/eventEmitter/eventEmitter.js", d.build.vendor.js, 'uglify rename', 'event')


###
# Tasks
###
gulp.task 'misc', ->
  _do("#{d.src.misc}/**/*",  d.build.public)
gulp.task 'html', ->
  _do(["#{d.src.html}/**/*.jade", "!#{d.src.html}/**/_*.jade"],  d.build.public, 'jade')
gulp.task 'css', ->
  _do(d.src.css, d.build.css, 'sass')
gulp.task 'js', ->
  _do("#{d.src.js}/**/*.{coffee,cjsx}", d.build.js, 'cjsx uglify')
gulp.task 'img', ->
  _do("#{d.src.img}/**/*", d.build.img, 'imagemin')
gulp.task 'js:dev', ->
  _do("#{d.src.js}/**/*.{coffee,cjsx}", d.build.js, 'cjsx dev')
gulp.task 'img:dev', ->
  _do("#{d.src.img}/**/*", d.build.img, 'imagemin dev')

gulp.task 'backend', ->
  _do(["!#{d.src.backend}/**/*.coffee", "#{d.src.backend}/**/*"], _build)
  _do("#{d.src.backend}/**/*.coffee", _build, 'cjsx uglify')

gulp.task 'shared', ->
  _do("#{d.src.shared}/**/*.coffee", d.build.js, 'coffee')
  _do("#{d.src.shared}/**/*.coffee", _build, 'coffee')



###
# Build
###
gulp.task 'build:backend', ['shared', 'backend']
gulp.task 'build:static:dev', ['vendor', 'shared', 'misc', 'html', 'css', 'js:dev', 'img:dev']
gulp.task 'build:static:prod', ['vendor', 'shared', 'misc', 'html', 'js', 'css', 'img']
gulp.task 'build:dev', ['build:static:dev', 'build:backend']
gulp.task 'build:prod', ['build:static:prod', 'build:backend']


###
# Watch/BrowserSync
###
gulp.task 'watch', ['watch:backend', 'watch:static']

gulp.task 'env', ->
  enviro vars: { NODE_ENV: 'development' }

gulp.task 'watch:backend', ['env', 'supervisor'], ->
  gulp.watch ["!#{d.src.backend}/public", "#{d.src.backend}/**/*"], ['backend', sync.reload]

gulp.task 'watch:static', ['browser-sync'], ->
  gulp.watch "#{d.src.js}/**/*.{coffee,cjsx}", ['js:dev', sync.reload]
  gulp.watch "#{d.src.css}/**/*.sass", ['css']
  gulp.watch "#{d.src.html}/**/*.jade", ['html', sync.reload]
  gulp.watch "#{d.src.shared}/**/*.coffee", ['shared', sync.reload]

gulp.task 'supervisor', ['build:backend'], ->
  supervisor "#{_build}/server.js",
    ignore: "#{_build}/public"
    extensions: 'js'
    debug: true

gulp.task 'browser-sync', ['build:static:dev'], ->
  sync
    proxy: "localhost:#{env.PORT}"
    port: env.BROWSERSYNC_PORT
    open: false


###
# Deploy Heroku
###
heroku = (prod) ->
  app = "#{env.HEROKU_STATIC.toLowerCase()}#{unless prod then '-qa' else ''}"

  ->
    CMDS = [
      "cd #{_build}"
      "rm -rf .git"
      "git init"
      "git add -A"
      "git commit -m '.'"
      "git remote add heroku git@heroku.com:#{app}.git"
      "git push -fu heroku master"
    ].join(' && ')

    exec CMDS, (err, stdout, stderr) ->
      process.stdout.write stdout
      process.stdout.write stderr

deploy = (prod) ->
  ->
    CMDS = [
      "gulp clean"
      "gulp build:prod"
      "gulp heroku:#{if prod then 'prod' else 'qa'}"
    ].join(' && ')

    exec CMDS, (err, stdout, stderr) ->
      process.stdout.write stdout
      process.stdout.write stderr

gulp.task 'heroku:qa', heroku(false)
gulp.task 'heroku:prod', heroku(true)
gulp.task 'deploy:qa', deploy(false)
gulp.task 'deploy:prod', deploy(true)


###
# Default
###
gulp.task 'default', ['watch']

