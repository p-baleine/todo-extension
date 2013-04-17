define [
  "backbone"
  "Squire"
], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "list-view", ->

    before ->
      @itemRenderSpy = sinon.spy -> @
      @ItemViewMock = Backbone.View.extend
        render: @itemRenderSpy
      injector.mock
        "views/item-view": => @ItemViewMock

    after ->
      injector.clean()

    beforeEach ->
      @itemRenderSpy.reset()

    describe "#render()", ->
      beforeEach (done) ->
        @todos = new Backbone.Collection [{ title: "hoge" }]
        injector.require ["views/list-view"], (ListView) =>
          @view = new ListView collection: @todos
          done()

      it "should render item-views", ->
        @view.render()
        expect(@itemRenderSpy.called).to.be.ok()      