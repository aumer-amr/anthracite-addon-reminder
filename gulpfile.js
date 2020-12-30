const gulp = require('gulp');
const zip = require('gulp-zip');
const copy = require('gulp-copy');
const debug = require('gulp-debug');
const package = require('./package.json');
const del = require('del');
 
gulp.task('dist', () => (
    gulp.src(['src/.*', 'src/*.*'])
        .pipe(copy(`dist/${package['addon-name']}`, { prefix: 1 }))));

gulp.task('zip', () => (
    gulp.src(['dist/*/**'])
        .pipe(debug())
        .pipe(zip(`${package['addon-name']}-v${package.version}.zip`))
        .pipe(gulp.dest('build'))));

gulp.task('cleanup', () => (
    del('dist', { force: true })
));

gulp.task('build', gulp.series('dist', 'zip', 'cleanup'));