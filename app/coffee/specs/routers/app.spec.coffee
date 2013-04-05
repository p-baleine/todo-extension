
define ["backbone", "Squire"], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "app"  , ->

    before ->
      @ListViewMock = Backbone.View.extend()
      injector.mock
        "views/list-view": => @ListViewMock

    after ->
      injector.clean()

    describe "#index", ->

      beforeEach (done) ->
        @initializeSpy = sinon.spy @, "ListViewMock"
        injector.require ["routers/app"], (AppRouter) =>
          @router = new AppRouter
          done()

      afterEach ->
        @ListViewMock.restore()

      it "should instantiate ListView", ->
        @router.index()
        expect(@initializeSpy.called).to.be.ok()
  