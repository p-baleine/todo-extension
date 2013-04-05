
module.exports = (grunt) ->
  grunt.initConfig
    watch:
      files: ["app/coffee/**/*.coffee"],
      tasks: ["coffee"]
    coffee:
      compileWithMaps:
        options:
          sourceMap: true
        files: [
          {
            expand: true,
            cwd: "app/coffee/",
            src: ["**/*.coffee"],
            dest: "app/js/",
            ext: ".js",
          }
        ]
    karma:
      unit:
        configFile: 'karma.conf.js',
        autoWatch: true

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-karma"
