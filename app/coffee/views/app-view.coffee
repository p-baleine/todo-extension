
define [
  "jquery"
  "underscore"
  "backbone"
  "views/list-view"
  "text!templates/app.html"
], ($, _, Backbone, ListView, appTemplate) ->

  class AppView extends Backbone.View

    events:
      "keydown [name=new-item]": "create"

    initialize: ->
      @collection.bind "reset", @render
      @collection.bind "change-remain remove add", @updateStats

    render: (filter = "none") =>
      @$el.html @template(remain: @collection.remain())
      @listView = new ListView el: @$("#list-container"), collection: @collection
      @listView.render filter
      @$("#filters").removeClass().addClass filter
      @

    create: (e) ->
      return if (e.keyCode? and e.keyCode isnt 13) or (e.which? and e.which isnt 13)
      e.preventDefault()
      target = $(e.target)
      @collection.create title: target.val()
      target.val ""

    updateStats: =>
      @$("#remain strong").text @collection.remain()

    template: _.template appTemplate
