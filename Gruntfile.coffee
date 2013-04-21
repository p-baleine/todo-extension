module.exports = (grunt) ->
  grunt.initConfig
    watch:
      coffee:
        files: ["app/coffee/**/*.coffee"]
        tasks: ["coffee"]
      template:
        files: ["app/coffee/templates/*.html"]
        tasks: ["copy"]
    coffee:
      compileWithMaps:
        options:
          sourceMap: true
        files: [
          {
            expand: true
            cwd: "app/coffee/"
            src: ["**/*.coffee"]
            dest: "app/js/"
            ext: ".js"
          }
        ]
    copy:
      main:
        files: [
          {
            expand: true
            cwd: "app/coffee/templates/"
            src: ["*.html"]
            dest: "app/js/templates"
          }
        ]
    karma:
      unit:
        configFile: 'karma.conf.js'
        autoWatch: true
      ci:
        configFile: 'karma.conf.js'
        browsers: ["PhantomJS"]
        singleRun: true

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-karma"
