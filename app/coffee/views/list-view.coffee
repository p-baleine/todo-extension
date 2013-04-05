
define [
  "jquery",
  "backbone",
  "collections/todo",
  "views/item-view"
], ($, Backbone, Todos, ItemView) ->

  ListView = Backbone.View.extend

    initialize: ->
      @collection = new Todos
      @collection.on "reset", @render, @
      @collection.fetch()

    render: ->
      @collection.each @renderOne, @

    renderOne: (model) ->
      view = new ItemView model: model.toJSON()
      view.render()
