define [
  "jquery"
  "underscore"
  "backbone"
  "text!templates/todo.html"
], ($, _, Backbone, itemTemplate) ->

  # Todo item view.
  ItemView = Backbone.View.extend

    className: "todo-item"

    tagName: "li"

    # Render this view.
    render: ->
      @$el.html @template(@model.toJSON())
      @

    # Template.
    template: _.template itemTemplate
