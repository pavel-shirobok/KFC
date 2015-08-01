var gulp = require('gulp');
var coffee = require('gulp-coffee');
var watch = require('gulp-watch');
var stylus = require('gulp-stylus');
var zip = require('gulp-zip');

var JS = [
    'src/coffee/**/*.coffee'
];

var MANIFEST = 'src/manifest.json'

var LIBS  = 'src/libs/**/*.js';

var IMG = 'src/images/**/*.*';
var STYLUS = 'src/stylus/*.styl';

gulp.task('kfr:coffee', function(){
    return gulp
        .src(JS, {base : "src/coffee"})
        .pipe(coffee())
        .pipe(gulp.dest('build/js'))
});

gulp.task('kfr:libs', function(){
    return gulp
        .src(LIBS)
        .pipe(gulp.dest('build/libs'))
})

gulp.task('kfr:stylus', function(){
    return gulp.src(STYLUS)
        .pipe(stylus())
        .pipe(gulp.dest('build/css'))
})

gulp.task('kfr:manifest', function(){
    return gulp
        .src(MANIFEST)
        .pipe(gulp.dest('build/'))
});

gulp.task('kfr:img', function(){
    return gulp
        .src(IMG)
        .pipe(gulp.dest('build/img/'))
});

gulp.task('kfr:watch', function(){
    watch(JS, function(){
        gulp.start('kfr:coffee')
    })

    watch(MANIFEST, function(){
        gulp.start('kfr:manifest')
    })

    watch(LIBS, function(){
        gulp.start('kfr:libs')
    })

    watch(IMG, function(){
        gulp.start('kfr:img')
    })

    watch(STYLUS, function(){
        gulp.start('kfr:stylus')
    })

    gulp.start('kfr:stylus');

    gulp.start('kfr:img');

    gulp.start('kfr:coffee');
    gulp.start('kfr:manifest');
    gulp.start('kfr:libs');

});

gulp.task('deploy', function(){
        var manifest = require('./src/manifest.json')
        gulp.src('build/**/*').
            pipe(zip('build_v' + manifest.version + '.zip')).
            pipe(gulp.dest('./builds/'));
    });