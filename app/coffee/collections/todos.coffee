define [
  "jquery"
  "backbone"
  "chromeStorage"
  "models/todo"
], ($, Backbone, chromeStorage, Todo) ->

  class Todos extends Backbone.Collection

    chromeStorage: new Backbone.ChromeStorage "Todos", "sync"

    model: Todo

    remain: ->
      @where(done: false).length