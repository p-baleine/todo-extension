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
      "click .destroy": "destroy"

    # Initializaton.
    initialize: ->
      @model.bind "destroy", @remove, @

    # Render this view.
    render: ->
      @$el.html @template(@model.toJSON())
      @

    # Update model.
    update: ->
      done = @$(".done").is(":checked")
      @model.save done: done
      @$el.toggleClass "done", done

    # Destroy handler.
    destroy: ->
      @model.destroy()

    # Template.
    template: _.template itemTemplate
