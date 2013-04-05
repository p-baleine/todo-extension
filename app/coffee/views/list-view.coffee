define [
  "jquery",
  "backbone",
  "collections/todos",
  "views/item-view",
], ($, Backbone, Todos, ItemView) ->

  # Todo list view.
  ListView = Backbone.View.extend

    # Initialization.
    initialize: ->
      @collection = new Todos
      @collection.on "reset", @render, @
      @collection.fetch()

    # Render all todos.
    render: ->
      @collection.each @renderOne, @

    # Render one todo.
    renderOne: (model) ->
      view = new ItemView model: model
      @$el.append view.render().el
