
define [
  "jquery"
  "underscore"
  "backbone"
  "text!templates/app.html"
], ($, _, Backbone, appTemplate) ->

  AppView = Backbone.View.extend

    events:
      "keydown [name=new-item]": "create"

    render: ->
      @.$el.html @template()
      @

    create: (e) ->
      return if not e.keyCode? or e.keyCode isnt 13
      e.preventDefault()
      @collection.create title: $(e.target).val()

    template: -> _.template appTemplate
