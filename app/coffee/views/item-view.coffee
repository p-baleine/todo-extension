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
      "dblclick .view": "edit"
      "keydown .edit": "update"
      "change .done": "update"
      "click .destroy": "destroy"

    # Initializaton.
    initialize: ->
      @model.bind "destroy", @remove, @
      @model.bind "change:title", @render

    # Render this view.
    render: =>
      @$el.html @template(@model.toJSON())
      @$el.addClass "done" if @model.get("done")
      @

    # Make editable.
    edit: ->
      @$el.addClass "editable"

    # Update model.
    update: (e) ->
      return if (e.keyCode? and e.keyCode isnt 13) or (e.which? and e.which isnt 13)
      e.preventDefault()
      done = @$(".done").is(":checked")
      @model.save title: @$(".edit").val(), done: done
      @$el.toggleClass "done", done
      @$el.removeClass "editable"

    # Destroy handler.
    destroy: ->
      @model.destroy()

    # Template.
    template: _.template itemTemplate