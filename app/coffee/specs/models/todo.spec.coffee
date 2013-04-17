
define [
  "backbone"
  "models/todo"
], (Backbone, Todo) ->

  describe "todo", ->

    beforeEach ->
      @model = new Todo

    it "should be an instance of Backbone.Model", ->
      expect(@model).to.be.a Backbone.Model
