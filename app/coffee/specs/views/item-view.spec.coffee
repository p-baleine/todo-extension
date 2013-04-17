define [
  "backbone"
  "Squire"
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

      it "should `li` as its tagName", ->
        expect(@view.render().el.tagName).to.match /li/i

      it "should has `todo-item` as its class name", ->
        expect(@view.$el.hasClass "todo-item").to.be.ok()