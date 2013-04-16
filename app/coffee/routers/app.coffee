
define [
  "jquery"
  "backbone"
  "views/app-view"
  "views/list-view"
], ($, Backbone, AppView, ListView) ->

  # App router.
  AppRouter = Backbone.Router.extend

    routes:
      "": "index"

    # Initialization.
    initialize: ->
      @appView = (new AppView el: "body").render()
      @listView = new ListView el: @appView.$("#list-container")

    # `index` route
    index: ->
