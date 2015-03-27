gulp        = require 'gulp'
rename      = require 'gulp-rename'
plumber     = require 'gulp-plumber'
browserify  = require 'browserify'
runSequence = require 'run-sequence'
source      = require 'vinyl-source-stream'
buffer      = require 'vinyl-buffer'
del         = require 'del'
globule     = require 'globule'

# �e�g�����X�p�C��
ts          = require 'gulp-typescript'
cjsx        = require 'gulp-coffee-react' # React��CoffeeScript�ŏ���
babel       = require 'gulp-babel'        # ES6��JS�r���h�p(React�͕W���T�|�[�g)

errorHandler = (err) -> console.log(err.toString())

gulp.task 'build:lib', ['build:ts', 'build:cjsx', 'build:babel', 'build:html']

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

gulp.task 'build:html', () ->
  gulp.src('src/**/*.html')
    .pipe(gulp.dest 'public')
   
gulp.task 'browserify', () ->
  
  args =
    debug: false
  
  b = browserify(args)
  # �\�[�X��ǉ�
  for x in globule.find('./lib/**/*.js')
    b.add(x)
    b.require(x)
  # bundle
  b
    .transform("react-jade")
    .bundle()
    .on('error', errorHandler)
    .pipe(source 'bundle.js')
    .pipe(buffer())
    .pipe(gulp.dest 'public')
 
gulp.task 'build', (cb) -> runSequence('clean', 'build:lib', 'browserify', cb)

gulp.task 'clean', (cb) -> del(['public', 'lib'], cb)

gulp.task 'default', () ->
  console.log 'usage) gulp (build | clean)'
