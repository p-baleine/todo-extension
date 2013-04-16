define [
  "jquery"
  "backbone"
  "views/list-view"
], ($, Backbone, ListView) ->

  # App router.
  AppRouter = Backbone.Router.extend

    routes:
      "": "index"

    # Start this app.
    index: ->
      new ListView el: "body"
