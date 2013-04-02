
require.config
  paths:
    "jquery": "../vendor/jquery/jquery",
    "underscore": "../vendor/underscore-amd/underscore",
    "backbone": "../vendor/backbone-amd/backbone",

require ["routers/app"], (App) ->
  new App
