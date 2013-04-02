
module.exports = (grunt) ->
  grunt.initConfig
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

  grunt.loadNpmTasks "grunt-contrib-coffee"
