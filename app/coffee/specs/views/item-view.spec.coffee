
define [
  "backbone",
  "Squire",
], (Backbone, Squire) ->

  describe "item-view", ->

    beforeEach (done) ->
      require ["views/item-view"], (ItemView) =>
        @model = new Backbone.Model title: "DailyJS"
        @view = new ItemView model: @model
        done()

    it "should be an instance of Backbone.View", ->
      expect(@view).to.be.a Backbone.View

    describe "#render", ->

      it "should render title", ->
        expect(@view.render().$el.html()).to.contain @model.get("title")

  