
define [
  "backbone"
  "views/app-view"
], (Backbone, AppView) ->

  describe "app-view", ->

    beforeEach ->
      @view = new AppView

    it "should be an instance of Backbone.View", ->
      expect(@view).to.be.a Backbone.View

    describe "#render()", ->

      it "should render `#list-container`", ->
        expect(@view.render().$("#list-container")).to.not.empty()