
require.config
  paths:
    "jquery": "../vendor/jquery/jquery",
    "underscore": "../vendor/underscore-amd/underscore",
    "backbone": "../vendor/backbone-amd/backbone",
    "chromeStorage": "../vendor/backbone.chromeStorage/backbone.chromestorage",
    "text": "../vendor/requirejs-text/text"

require ["backbone", "routers/app"], (Backbone, App) ->
  new App
  Backbone.history.start()