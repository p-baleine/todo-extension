
define [
  "backbone"
], (Backbone) ->

  class Todo extends Backbone.Model

    defaults:
      done: false