###
Modules
###
_           = require('lodash')
chalk       = require('chalk')
gulp        = require('gulp')
clean       = require('gulp-rimraf')
cjsx        = require('gulp-cjsx')
concat      = require('gulp-concat')
filter      = require('gulp-filter')
iif         = require('gulp-if')
imagemin    = require('gulp-imagemin')
jade        = require('gulp-jade')
minify      = require('gulp-minify-css')
plumber     = require('gulp-plumber')
rename      = require('gulp-rename')
sass        = require('gulp-ruby-sass')
nodemon     = require('gulp-nodemon')
uglify      = require('gulp-uglify')
sync        = require('browser-sync')

###
Variables
###
key = require('./key.json')
env = require('./env.json')
data = _.extend({}, (key or {}), env)


###
Process Handler
###
{ exec, spawn } = require('child_process')
killSwitchActivated = true
children = []

addProcess = (task, color='gray') ->
  child = spawn('gulp', ["#{task}:process"], { cwd: __dirname})
  child.stdout.on 'data', (data) ->
    process.stdout.write(chalk[color](data.toString()))
  child.stderr.on 'data', (data) ->
    process.stdout.write(chalk[color](data.toString()))
  children.push(child)

killSwitch = ->
  return unless killSwitchActivated
  process.stdout.write(chalk.red('\nKilling child processes...\n'))
  child.kill() for child in children

process.on("exit", killSwitch)


###
Directory Paths
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
Tasker
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
Clean
###
gulp.task 'clean', ->
  gulp.src(_build, {read: false}).pipe(clean())
gulp.task 'clean:modules', ['clean'], ->
  gulp.src(d.modules, {read: false}).pipe(clean())
  gulp.src(d.src.vendor, {read: false}).pipe(clean())

gulp.task 'clean:all', ['clean', 'clean:modules']


###
Vendor Files
###
gulp.task 'vendor', ->
  _do("#{d.src.vendor}/requirejs/require.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/zepto/zepto.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/lodash/lodash.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/react/react-with-addons.js", d.build.vendor.js, 'uglify rename', 'react')
  _do("#{d.src.vendor}/flux/dist/Flux.js", d.build.vendor.js, 'uglify rename', 'flux')
  _do("#{d.src.vendor}/eventEmitter/eventEmitter.js", d.build.vendor.js, 'uglify rename', 'event')
  _do("#{d.src.vendor}/backbone/backbone.js", d.build.vendor.js, 'uglify')
  _do("#{d.src.vendor}/icono/icono.min.css", d.build.vendor.css)
  _do("#{d.src.vendor}/masonry/dist/masonry.pkgd.min.js", d.build.vendor.js, 'rename', 'masonry')
  _do("#{d.src.vendor}/imagesloaded/imagesloaded.pkgd.min.js", d.build.vendor.js, 'rename', 'imagesloaded')
  _do("#{d.src.vendor}/velocity/velocity.min.js", d.build.vendor.js, 'rename', 'velocity')
  _do("#{d.src.vendor}/bluebird/js/browser/bluebird.min.js", d.build.vendor.js, 'rename', 'bluebird')



###
Tasks
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
Build
###
gulp.task 'build:backend', ['shared', 'backend']
gulp.task 'build:static:dev', ['shared', 'misc', 'html', 'css', 'js:dev', 'img:dev']
gulp.task 'build:static:prod', ['vendor', 'shared', 'misc', 'html', 'js', 'css', 'img']
gulp.task 'build:dev', ['build:static:dev', 'build:backend']
gulp.task 'build:prod', ['build:static:prod', 'build:backend']


###
Watch/BrowserSync
###
gulp.task 'watch', ['watch:backend', 'watch:static']

gulp.task 'watch:backend', ['nodemon'], ->
  gulp.watch ["!#{d.src.backend}/public", "#{d.src.backend}/**/*"], ['backend', sync.reload]

gulp.task 'watch:static', ['browser-sync'], ->
  gulp.watch "#{d.src.js}/**/*.{coffee,cjsx}", ['js:dev', sync.reload]
  gulp.watch "#{d.src.css}/**/*.sass", ['css']
  gulp.watch "#{d.src.html}/**/*.jade", ['html', sync.reload]
  gulp.watch "#{d.src.shared}/**/*.coffee", ['shared', sync.reload]

gulp.task 'nodemon', ->
  addProcess 'nodemon', 'cyan'

gulp.task 'nodemon:process', ['build:backend'], ->
  ignore = ["#{d.build.public[2..]}/", "#{d.modules[2..]}/"]
  nodemon
    script: "#{_build}/server.js"
    ignore: ignore
    nodeArgs: ['--debug']
    env:
      NODE_ENV: 'development'
      DEBUG: 'NickAndBora'

gulp.task 'browser-sync', ['build:static:dev'], ->
  sync
    proxy: "localhost:#{env.PORT}"
    port: env.BROWSERSYNC_PORT
    open: false
    notify: false


###
Deploy Heroku
###
run = (cmd, cwd, cb) ->
  opts = if cwd then { cwd } else {}
  parts = cmd.split(/\s+/g)
  p = spawn(parts[0], parts[1..], opts)
  p.stdout.on 'data', (data) ->
    process.stdout.write(chalk.gray(data.toString()))
  p.stderr.on 'data', (data) ->
    process.stdout.write(chalk.gray(data.toString()))
  p.on 'exit', (code) ->
    err = null
    if code
      err = new Error("command #{cmd} exited with wrong status code: #{code}")
      err = _.extend {}, err, { code, cmd }
    cb?(err)

series = (cmds, cwd, cb) ->
  do execNext = ->
    run cmds.shift(), cwd, (err) ->
      return cb(err) if err
      if cmds.length then execNext() else cb(null)

heroku = (prod) ->
  killSwitchActivated = false
  app = "#{env.HEROKU_STATIC.toLowerCase()}#{unless prod then '-qa' else ''}"

  ->
    CMDS = [
      "rm -rf .git"
      "git init"
      "git add -A"
      "git commit -m '.'"
      "git remote add heroku git@heroku.com:#{app}.git"
      "git push -fu heroku master"
    ]

    series CMDS, _build, (err) ->
      if err
        console.log err
        console.log(chalk.red('[Error] Deploy to Heroku failed!'))
      else
        console.log(chalk.green('[Success] Deploy to Heroku successful!'))

deploy = (prod) ->
  killSwitchActivated = false
  ->
    CMDS = [
      "gulp clean"
      "gulp build:prod"
      "gulp heroku:#{if prod then 'prod' else 'qa'}"
    ]

    series CMDS, null, (err) ->
      if err
        console.log(chalk.red('[Error] Deploy failed!'))
      else
        console.log(chalk.green('[Success] Deploy successful!'))

gulp.task 'heroku:qa', heroku(false)
gulp.task 'heroku:prod', heroku(true)
gulp.task 'deploy:qa', deploy(false)
gulp.task 'deploy:prod', deploy(true)


###
Default
###
gulp.task 'default', ['watch']


