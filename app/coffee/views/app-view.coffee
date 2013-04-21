
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

    render: =>
      @.$el.html @template(remain: @collection.remain())
      @listView = new ListView el: @$("#list-container"), collection: @collection
      @listView.render()
      @

    create: (e) ->
      return if (e.keyCode? and e.keyCode isnt 13) or (e.which? and e.which isnt 13)
      e.preventDefault()
      target = $(e.target)
      @collection.create title: target.val()
      target.val ""

    template: _.template appTemplate
