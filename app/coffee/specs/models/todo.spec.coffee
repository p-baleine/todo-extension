
define [
  "backbone"
  "models/todo"
], (Backbone, Todo) ->

  describe "todo", ->

    beforeEach ->
      @collection
      @model = new Todo {}, collection: @collection

    it "should be an instance of Backbone.Model", ->
      expect(@model).to.be.a Backbone.Model

    it "should set default value of done as false", ->
      expect(@model.get("done")).to.be(false)

  describe "when done status change", ->

    it "should trigger `change-remain` to its collection", ->
      spy = sinon.spy()
      @collection.on "change-remain", spy
      @model.set done: true
      expect(spy.called).to.be.ok()
