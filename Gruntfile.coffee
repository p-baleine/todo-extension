module.exports = (grunt) ->
  grunt.initConfig
    watch:
      coffee:
        files: ["app/coffee/**/*.coffee"]
        tasks: ["coffee"]
      template:
        files: ["app/coffee/templates/*.html"]
        tasks: ["copy:template"]
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
      template:
        files: [
          {
            expand: true
            cwd: "app/coffee/templates/"
            src: ["*.html"]
            dest: "app/js/templates"
          }
        ]
      build:
        files: [
          {
            expand: true
            cwd: "./"
            src: ["todo.html", "style.css", "manifest.json", "icon.png"]
            dest: "dist"
          }
          {
            expand: true
            cwd: "app/vendor/requirejs/"
            src: ["require.js"]
            dest: "dist/app/vendor/requirejs"
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
    requirejs:
      compile:
        options:
          name: "main"
          mainConfigFile: "app/js/main.js"
          out: "dist/app/js/main.js"
    zip:
      dist:
        cwd: "dist/"
        src: ["dist/**/*"]
        dest: "dist.zip"
    clean: ["dist", "dist.js", "app/js"]
    bumpVersion:
      dist:
        files:
          src: ["package.json", "bower.json", "manifest.json"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-karma"
  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-zip"

  grunt.loadTasks "tasks"

  grunt.registerTask "dist", [
    "clean"
    "coffee"
    "copy:template"
    "requirejs"
    "copy:build"
    "zip"
  ]
