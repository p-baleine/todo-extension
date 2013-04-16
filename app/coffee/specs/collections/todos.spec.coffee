
define [
  "backbone",
  "Squire",
], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "todos", ->

    before ->
      @storageStub = sinon.stub()
      injector.mock
        "chromeStorage": define "chromeStorage", [
            'jquery',
            'underscore',
            'backbone',
          ], ($, _, Backbone) =>
            Backbone.ChromeStorage = @storageStub

    after ->
      Backbone.ChromeStorage = undefined
      injector.clear

    beforeEach (done) ->
      injector.require ["collections/todos"], (Todos) =>
        @collection = new Todos
        done()

    it "should use chrome.strage.*", ->
      expect(@storageStub).to.be.ok()
