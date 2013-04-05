
define [
  "jquery",
  "underscore",
  "backbone",
  "text!templates/todo.html",
], ($, _, Backbone, itemTemplate) ->

  ItemView = Backbone.View.extend

    render: ->
      @$el.html @template(@model.toJSON())
      @

    template: _.template itemTemplate

