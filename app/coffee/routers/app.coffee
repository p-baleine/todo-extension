
define ["jquery", "backbone", "views/list-view"], ($, Backbone, ListView) ->

  AppRouter = Backbone.Router.extend

    routes:
      "": "index"

    index: () ->
      new ListView
      $("body").append($("<div/>", text: "Hello, world!!!"))
