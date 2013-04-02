
module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compileWithMaps:
        options:
          sourceMap: true
        files: [
          {
            expand: true,
            cwd: "app/",
            src: ["coffee/**/*.coffee"],
            dest: "js/",
            ext: ".js",
          }
        ]

  grunt.loadNpmTasks "grunt-contrib-coffee"
