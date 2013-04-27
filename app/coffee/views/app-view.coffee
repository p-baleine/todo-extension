
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

    # Initialize.
    initialize: ->
      @collection.bind "reset", @render, "none"
      @collection.bind "change-remain remove add", @updateStats

    # Render.
    render: (filter) =>
      filter = "none" unless _.isString filter
      @$el.html @template(remain: @collection.remain())
      @listView = new ListView el: @$("#list-container"), collection: @collection
      @listView.render filter
      @$("#filters a").removeClass "on"
      @$("#filters .#{filter}").addClass "on"
      @

    # Create todo.
    create: (e) ->
      return if (e.keyCode? and e.keyCode isnt 13) or (e.which? and e.which isnt 13)
      e.preventDefault()
      target = $(e.target)
      @collection.create title: target.val()
      target.val ""

    # Update stats field with current status.
    updateStats: =>
      @$("#remain strong").text @collection.remain()

    # Template.
    template: _.template appTemplate
