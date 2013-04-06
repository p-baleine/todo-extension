define [
  "jquery"
  "backbone"
], ($, Backbone) ->

  Todos = Backbone.Collection.extend

    fetch: ->
      @reset [{ title: "hoge" }, { title: "hoge" }]

