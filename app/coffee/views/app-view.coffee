
define [
  "jquery"
  "underscore"
  "backbone"
  "text!templates/app.html"
], ($, _, Backbone, appTemplate) ->

  AppView = Backbone.View.extend

    render: ->
      @.$el.html @template()
      @

    template: -> _.template appTemplate
