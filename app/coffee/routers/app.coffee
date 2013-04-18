
define [
  "jquery"
  "backbone"
  "collections/todos"
  "views/app-view"
  "views/list-view"
], ($, Backbone, Todos, AppView, ListView) ->

  # App router.
  class AppRouter extends Backbone.Router

    routes:
      "": "index"

    # Initialization.
    initialize: ->
      @todos = new Todos
      @appView = (new AppView el: "body", collection: @todos).render()
      @listView = new ListView el: @appView.$("#list-container"), collection: @todos

    # `index` route
    index: ->
      @todos.fetch()
