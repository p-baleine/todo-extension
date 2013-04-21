
define [
  "jquery"
  "backbone"
  "collections/todos"
  "views/app-view"
], ($, Backbone, Todos, AppView) ->

  # App router.
  class AppRouter extends Backbone.Router

    routes:
      "": "index"

    # Initialization.
    initialize: ->
      @todos = new Todos
      @appView = new AppView el: "body", collection: @todos

    # `index` route
    index: ->
      @todos.fetch(reset: true)
