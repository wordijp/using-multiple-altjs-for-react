gulp        = require 'gulp'
rename      = require 'gulp-rename'
plumber     = require 'gulp-plumber'
browserify  = require 'browserify'
runSequence = require 'run-sequence'
source      = require 'vinyl-source-stream'
buffer      = require 'vinyl-buffer'
del         = require 'del'
globule     = require 'globule'
header      = require 'gulp-header'

# �e�g�����X�p�C��
ts          = require 'gulp-typescript'
cjsx        = require 'gulp-coffee-react'                # jsx�\�����g����CoffeeScript
babel       = require 'gulp-babel'                       # ES6�\����ES5�\���֕ϊ�����AReact��jsx�\�����W���T�|�[�g
reactJade   = require './scripts/forked-gulp-react-jade' # react-jade�e���v���[�g��JS�R�[�h�֕ϊ�����

errorHandler = (err) -> console.log(err.toString())

gulp.task 'build:lib', ['build:ts', 'build:cjsx', 'build:babel', 'build:react-jade', 'build:html']

ts_proj = ts.createProject({
  target: "ES6"
  module: "commonjs"
  sortOutput: true
})
gulp.task 'build:ts', () ->
  gulp.src(['src/**/*.ts', '!src/**/*.d.ts'])
    .pipe(plumber(
      errorHandler: errorHandler
    ))
    .pipe(ts ts_proj)
    .js
    .pipe(gulp.dest 'lib')

gulp.task 'build:cjsx', () ->
  gulp.src('src/**/*.cjsx')
    .pipe(plumber(
      errorHandler: errorHandler
    ))
    .pipe(cjsx())
    .pipe(gulp.dest 'lib')
    
gulp.task 'build:babel', () ->
  gulp.src('src/**/*.js6')
    .pipe(plumber(
      errorHandler: errorHandler
    ))
    .pipe(babel())
    .pipe(rename((path) ->
      # .js6�͏���ɕt�����g���q�Ȃ̂ŁA�����I��js�֕ύX���K�v
      path.basename = path.basename.replace(/.js6$/, '')
      path.extname = ".js"
      return # �����Ԃ��Ȃ�
    ))
    .pipe(gulp.dest 'lib')
    
gulp.task 'build:react-jade', () ->
  gulp.src('src/**/*.jade')
    .pipe(plumber(
      errorHandler: errorHandler
    ))
    .pipe(reactJade())
    # Browserify��bundle���Ă������悤�ɕK�v�ȃR�[�h��ǉ�����
    .pipe(header(
      "var React = require('react');\n" +
      "module.exports = "
    ))
    .pipe(rename((path) ->
      # gulp-react-jade�ŕt����ꂽ"-tmpl"����菜��
      # XXX : ���ߑł��Ȃ̂ł��܂��낵���Ȃ�
      path.basename = path.basename.replace(/-tmpl$/, '')
      return
    ))
    .pipe(gulp.dest 'lib')

gulp.task 'build:html', () ->
  gulp.src('src/**/*.html')
    .pipe(gulp.dest 'public')
   
gulp.task 'browserify', () ->
  
  args =
    debug: false
  
  b = browserify(args)
  # �\�[�X��ǉ�
  for x in globule.find(['./lib/**/*.js'])
    b.add(x)
    b.require(x)
  # bundle
  b
    .bundle()
    .on('error', errorHandler)
    .pipe(source 'bundle.js')
    .pipe(buffer())
    .pipe(gulp.dest 'public')
 
gulp.task 'build', (cb) -> runSequence('clean', 'build:lib', 'browserify', cb)

gulp.task 'clean', (cb) -> del(['public', 'lib'], cb)

gulp.task 'default', () ->
  console.log 'usage) gulp (build | clean)'
