
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
      @ListViewMock = sinon.spy Backbone.View.extend()
      injector.mock
        "views/app-view": => @AppViewMock
        "views/list-view": => @ListViewMock

    after ->
      injector.clean()

    beforeEach ->
      @AppViewMock.reset()
      @ListViewMock.reset()

    describe "#initialize()", ->

      beforeEach (done) ->
        injector.require ["routers/app"], (AppRouter) =>
          @router = new AppRouter
          done()

      describe "AppView", ->
  
        it "should instantiate AppView", ->
          expect(@AppViewMock.called).to.be.ok()
  
        it "should pass `body` to AppView as `el`", ->
          expect(@AppViewMock.lastCall.args[0]).to.have.property "el", "body"
  
        it "should render AppView", ->
          expect(@appViewRenderSpy.called).to.be.ok()

      describe "ListView", ->
  
        it "should instantiate ListView", ->
          expect(@ListViewMock.called).to.be.ok()

        it "should pass `#list-container` to ListView as `el`", ->
          expect(@ListViewMock.lastCall.args[0]).to.have.property "el"
          expect(@ListViewMock.lastCall.args[0].el.attr("id")).to.equal "list-container"
          