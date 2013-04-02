
define ["jquery", "backbone"], ($, Backbone) ->

  AppRouter = Backbone.Router.extend

    routes:
      "": "index"

    index: () ->
      $("body").append($("<div/>", text: "Hello, world!!!"))

  AppRouter
