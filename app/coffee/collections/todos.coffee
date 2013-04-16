
define [
  "jquery",
  "backbone",
  "chromeStorage",
], ($, Backbone, chromeStorage) ->

  Todos = Backbone.Collection.extend

    chromeStorage: new Backbone.ChromeStorage "Todos", "sync"

    fetch: ->
      @reset [{ title: "hoge" }, { title: "hoge" }]
