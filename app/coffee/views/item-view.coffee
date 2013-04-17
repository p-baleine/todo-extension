define [
  "jquery"
  "underscore"
  "backbone"
  "text!templates/todo.html"
], ($, _, Backbone, itemTemplate) ->

  # Todo item view.
  class ItemView extends Backbone.View

    className: "todo-item"

    tagName: "li"

    events:
      "change .done": "update"

    # Render this view.
    render: ->
      @$el.html @template(@model.toJSON())
      @

    # Update model.
    update: ->
      @model.save done: @$(".done").is(":checked")

    # Template.
    template: _.template itemTemplate
