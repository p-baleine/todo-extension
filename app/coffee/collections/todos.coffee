define [
  "jquery"
  "backbone"
  "chromeStorage"
  "models/todo"
], ($, Backbone, chromeStorage, Todo) ->

  Todos = Backbone.Collection.extend

    chromeStorage: new Backbone.ChromeStorage "Todos", "sync"

    model: Todo
