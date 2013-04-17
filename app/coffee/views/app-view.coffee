
define [
  "jquery"
  "underscore"
  "backbone"
  "text!templates/app.html"
], ($, _, Backbone, appTemplate) ->

  class AppView extends Backbone.View

    events:
      "keydown [name=new-item]": "create"

    render: ->
      @.$el.html @template()
      @

    create: (e) ->
      return if (e.keyCode? and e.keyCode isnt 13) or (e.which? and e.which isnt 13)
      e.preventDefault()
      target = $(e.target)
      @collection.create title: target.val()
      target.val ""

    template: -> _.template appTemplate
