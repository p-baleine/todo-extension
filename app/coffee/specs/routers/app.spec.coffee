
define [
  "backbone"
  "Squire"
], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "app", ->

    before ->
      @appViewRenderSpy = sinon.spy ->
        @.$el.html "<div id=\"list-container\"></div>"
        @
      @AppViewMock = sinon.spy Backbone.View.extend
        render: @appViewRenderSpy
      @todosFetchSpy = sinon.spy -> { then: (cb) -> cb() }
      @TodosMock = sinon.spy Backbone.Collection.extend
        fetch: @todosFetchSpy
      injector.mock
        "views/app-view": => @AppViewMock
        "collections/todos": => @TodosMock

    after ->
      injector.clean()

    beforeEach ->
      @AppViewMock.reset()
      @TodosMock.reset()
      @todosFetchSpy.reset()
      @appViewRenderSpy.reset()

    describe "#initialize()", ->

      beforeEach (done) ->
        injector.require ["routers/app"], (AppRouter) =>
          @router = new AppRouter
          done()

      it "should instantiate Todos", ->
        expect(@TodosMock.called).to.be.ok()

      describe "AppView", ->
  
        it "should instantiate AppView", ->
          expect(@AppViewMock.called).to.be.ok()
  
        it "should pass `body` to AppView as `el`", ->
          expect(@AppViewMock.lastCall.args[0]).to.have.property "el", "body"

        it "should pass `todos` to AppView as `collection`", ->
          expect(@AppViewMock.lastCall.args[0]).to.have.property "collection"
          expect(@AppViewMock.lastCall.args[0].collection).to.be.a(@TodosMock)

        it "should fetch todos", ->
          expect(@todosFetchSpy.called).to.be.ok()

        it "should fetch with reset true", ->
          expect(@todosFetchSpy.lastCall.args[0]).to.have.property "reset", true

    describe "route `index`", ->

      it "should render todos", ->
        @router.index()
        expect(@appViewRenderSpy.called).to.be.ok()
