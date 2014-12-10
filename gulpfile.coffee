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
_static = './_static'
_backend = './_backend'
_deploy = './_deploy'
d =
  modules: './node_modules'
  src:
    html: "#{_src}/frontend/html"
    js: "#{_src}/frontend/js"
    css: "#{_src}/frontend/css"
    img: "#{_src}/frontend/img"
    misc: "#{_src}/frontend/misc"
    vendor: "#{_src}/frontend/vendor"
    server: "#{_src}/frontend/server"
    backend: "#{_src}/backend"
    shared: "#{_src}/shared"
  static:
    root: "#{_static}"
    public: "#{_static}/public"
    js: "#{_static}/public/js"
    css: "#{_static}/public/css"
    img: "#{_static}/public/img"
    vendor:
      js: "#{_static}/public/js/vendor"
      css: "#{_static}/public/css/vendor"


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
  gulp.src(src)
    .pipe(do plumber) # Plumber
    .pipe(iif(_sass, sass({compass:true, style: 'compressed'}))) # Sass
    .pipe(iif(_jade, jade({data, pretty: true}))) # Jade
    .pipe(iif(_coffee, cjsx(bare:true))) # Coffee/React
    .pipe(iif(_uglify and not _dev, uglify(compress: drop_debugger: false))) # Uglify
    .pipe(iif(_minify and not _dev, minify())) # Minify
    .pipe(iif(_imagemin and not _dev, imagemin())) # Imagemin
    .pipe(iif(_rename and !!filename, rename(basename: filename))) # Rename
    .pipe(gulp.dest(dest)) # Destination
    .pipe(iif(_sass, filter('**/*.css'))) # Filter CSS
    .pipe(iif(_copy or _sass, sync.reload(stream: true))) # BrowserSync


###
# Configs
###
gulp.task 'config', ->
  _do('./env.json', _backend)


###
# Clean
###
gulp.task 'clean', ['clean:static', 'clean:backend']
gulp.task 'clean:static', ->
  gulp.src(_static, {read: false}).pipe(clean())
gulp.task 'clean:backend', ->
  gulp.src(_backend, {read: false}).pipe(clean())


###
# Clean libs
###
gulp.task 'wipe', ['clean'], ->
  gulp.src(d.modules, {read: false}).pipe(clean())
  gulp.src(d.src.vendor, {read: false}).pipe(clean())


###
# Vendor Files
###
gulp.task 'vendor', ->
  _do("#{d.src.vendor}/requirejs/require.js", d.static.vendor.js, 'uglify')
  _do("#{d.src.vendor}/zepto/zepto.js", d.static.vendor.js, 'uglify')
  _do("#{d.src.vendor}/lodash/dist/lodash.js", d.static.vendor.js, 'uglify')
  _do("#{d.src.vendor}/q/q.js", d.static.vendor.js, 'uglify')
  _do("#{d.src.vendor}/react/react-with-addons.js", d.static.vendor.js, 'uglify rename', 'react')
  _do("#{d.src.vendor}/flux/dist/Flux.js", d.static.vendor.js, 'uglify rename', 'flux')
  _do("#{d.src.vendor}/page/index.js", d.static.vendor.js, 'uglify rename', 'page')
  _do("#{d.src.vendor}/eventEmitter/eventEmitter.js", d.static.vendor.js, 'uglify rename', 'event')


###
# Tasks
###
gulp.task 'misc', ->
  _do("#{d.src.misc}/**/*",  d.static.public)
gulp.task 'html', ->
  _do(["#{d.src.html}/**/*.jade", "!#{d.src.html}/**/_*.jade"],  d.static.public, 'jade')
gulp.task 'css', ->
  _do("#{d.src.css}/**/*.sass", d.static.css, 'sass')
gulp.task 'js', ->
  _do("#{d.src.js}/**/*.{coffee,cjsx}", d.static.js, 'cjsx uglify')
gulp.task 'img', ->
  _do("#{d.src.img}/**/*", d.static.img, 'imagemin')
gulp.task 'js:dev', ->
  _do("#{d.src.js}/**/*.{coffee,cjsx}", d.static.js, 'cjsx dev')
gulp.task 'img:dev', ->
  _do("#{d.src.img}/**/*", d.static.img, 'imagemin dev')

gulp.task 'server', ->
  _do(["!#{d.src.server}/**/*.coffee", "#{d.src.server}/**/*"], _static)
  _do("#{d.src.server}/**/*.coffee", _static, 'cjsx uglify')

gulp.task 'backend', ->
  _do("#{d.src.backend}/**/*.coffee", _backend, 'coffee')
  _do("#{d.src.backend}/**/*.{text,jade,css}", _backend)

gulp.task 'shared', ->
  _do("#{d.src.shared}/**/*.coffee", d.static.js, 'coffee')
  _do("#{d.src.shared}/**/*.coffee", _backend, 'coffee')



###
# Build
###
gulp.task 'build:static:dev', ['server', 'vendor', 'shared', 'misc', 'html', 'css', 'js:dev', 'img:dev']
gulp.task 'build:static:prod', ['server', 'vendor', 'shared', 'misc', 'html', 'js', 'css', 'img']
gulp.task 'build:backend', ['config', 'shared', 'backend']


###
# Watch/BrowserSync
###
gulp.task 'watch', ['env', 'watch:backend', 'watch:static']

gulp.task 'env', ->
  enviro vars: { NODE_ENV: 'development' }

gulp.task 'watch:backend', ['server:backend'], ->
  gulp.watch "#{d.src.backend}/**/*", ['backend']

gulp.task 'watch:static', ['browser-sync'], ->
  gulp.watch "#{d.src.js}/**/*.{coffee,cjsx}", ['js:dev', sync.reload]
  gulp.watch "#{d.src.css}/**/*.sass", ['css', sync.reload]
  gulp.watch "#{d.src.html}/**/*.jade", ['html', sync.reload]
  gulp.watch "#{d.src.shared}/**/*.coffee", ['shared', sync.reload]

gulp.task 'server:backend', ['build:backend'], ->
  supervisor "#{_backend}/server.js",
    watch: _backend
    extensions: 'js'
    debug: true

gulp.task 'browser-sync', ['server:static'], ->
  sync
    proxy: "localhost:#{env.STATIC_PORT}"
    port: env.BROWSERSYNC_PORT
    open: false

gulp.task 'server:static', ['build:static:dev'], ->
  supervisor "#{_static}/server.js",
    watch: _static


###
# Deploy to Static to Heroku
###
gulp.task 'heroku:static', ->

  CMDS = [
    "cd #{_static}"
    "rm -rf .git"
    "git init"
    "git add -A"
    "git commit -m '.'"
    "git remote add heroku git@heroku.com:#{env.HEROKU_STATIC.toLowerCase()}.git"
    "git push -fu heroku master"
  ].join(' && ')

  exec CMDS, (err, stdout, stderr) ->
    process.stdout.write stdout
    process.stdout.write stderr


gulp.task 'deploy:static', ->

  CMDS = [
    "gulp clean"
    "gulp build:static:prod"
    "gulp heroku:static"
  ].join(' && ')

  exec CMDS, (err, stdout, stderr) ->
    process.stdout.write stdout
    process.stdout.write stderr


###
# Default
###
gulp.task 'default', ['watch']

