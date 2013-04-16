define [
  "jquery"
  "underscore"
  "backbone"
  "text!templates/todo.html"
], ($, _, Backbone, itemTemplate) ->

  # Todo item view.
  ItemView = Backbone.View.extend

    # Render this view.
    render: ->
      @$el.html @template(@model.toJSON())
      @

    # Template.
    template: _.template itemTemplate
