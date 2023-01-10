const gulp = require('gulp');
const sass = require('gulp-sass')(require('sass'));

function build() {
    return gulp.src('./styles/**/*.scss')
        .pipe(sass.sync().on('error', sass.logError))
        .pipe(gulp.dest('./tmp/stylesheets/'));
};

function watch() {
    gulp.watch('./styles/**/*.scss', build);
}

exports.build = build;
exports.watch = watch;

exports.default = watch;
