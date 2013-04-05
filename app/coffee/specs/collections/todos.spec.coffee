
define [
  "backbone",
  "Squire",
], (Backbone, Squire) ->

  describe "todos", ->

    beforeEach (done) ->
      require ["collections/todos"], (Todos) =>
        @collection = new Todos
        done()

    it "should be an instance of Backbone.Collection", ->
      expect(@collection).to.be.a Backbone.Collection
