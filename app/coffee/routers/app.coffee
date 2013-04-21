
define [
  "jquery"
  "backbone"
  "collections/todos"
  "views/app-view"
], ($, Backbone, Todos, AppView) ->

  # App router.
  class AppRouter extends Backbone.Router

    routes:
      "index": "index"
      "index/:filter": "index"

    # Initialization.
    initialize: ->
      @todos = new Todos
      @appView = new AppView el: "body", collection: @todos
      @todos.fetch reset: true

    # `index` route
    index: (filter = "none") ->
      @appView.render filter
