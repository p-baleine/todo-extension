# bump versions of specified files.
module.exports = (grunt) ->

  grunt.registerMultiTask "bumpVersion", "Bump versions", ->
    version = grunt.option("env").split("=")[1]

    unless version?
      grunt.log.write "Please specify version via env parameter, e.g., version=0.0.4"
      return

    @filesSrc.forEach (filepath) ->
      return unless grunt.file.exists filepath

      grunt.log.write "Bump version #{filepath}..."
      file = grunt.file.readJSON(filepath)
      return unless file.version?
      file.version = version

      try
        grunt.file.write filepath, JSON.stringify(file, null, 2) + "\n"
        grunt.log.ok()
      catch e
        grunt.log.error()
        grunt.verbose.error e
        grunt.fail.warn "Bump versions operation failed."
