
define [
  "backbone"
], (Backbone) ->

  class Todo extends Backbone.Model

    defaults:
      done: false

    initialize: ->
      @on "change:done", => @collection.trigger "change-remain"
