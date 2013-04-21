define [
  "jquery"
  "backbone"
  "views/item-view"
], ($, Backbone, ItemView) ->

  # Todo list view.
  class ListView extends Backbone.View

    # Initialize.
    initialize: ->
      @collection.bind "add", @renderOne

    # Render all todos.
    render: (filter) =>
      switch filter
        when "active" then @collection.chain().where(done: false).each @renderOne
        when "completed" then @collection.chain().where(done: true).each @renderOne
        else @collection.each @renderOne

    # Render one todo.
    renderOne: (model) =>
      view = new ItemView model: model
      @$el.append view.render().el
