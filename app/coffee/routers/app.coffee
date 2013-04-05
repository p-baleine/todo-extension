
define ["jquery", "backbone", "views/list-view"], ($, Backbone, ListView) ->

  AppRouter = Backbone.Router.extend

    routes:
      "": "index"

    index: () ->
      new ListView el: "body"
