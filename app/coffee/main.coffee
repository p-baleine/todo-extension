
require.config
  paths:
    "jquery": "../vendor/jquery/jquery",
    "underscore": "../vendor/underscore-amd/underscore",
    "backbone": "../vendor/backbone-amd/backbone",

require ["backbone", "routers/app"], (Backbone, App) ->
  new App
  Backbone.history.start()