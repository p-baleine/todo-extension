define [
  "backbone"
  "Squire"
], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "todos", ->

    before ->
      @storageStub = sinon.stub()
      @TodoMock = Backbone.Model.extend()
      injector.mock
        "chromeStorage": define "chromeStorage", [
            'jquery'
            'underscore'
            'backbone'
          ], ($, _, Backbone) =>
            Backbone.ChromeStorage = @storageStub
        "models/todo": => @TodoMock

    after ->
      Backbone.ChromeStorage = undefined
      injector.clear

    beforeEach (done) ->
      injector.require ["collections/todos"], (Todos) =>
        @collection = new Todos
        done()

    it "should use chrome.strage.*", ->
      expect(@storageStub).to.be.ok()

    it "should have Todo as its model", ->
      expect(@collection).to.have.property "model", @TodoMock

    describe "#remain()", ->

      beforeEach ->
        @collection.reset [
          { title: "hello", done: true }
          { title: "world", done: false }
        ]

      it "should return the remain count of items", ->
        expect(@collection.remain()).to.equal 1
