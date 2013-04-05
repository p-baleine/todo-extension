
define ["backbone", "Squire"], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "list-view", ->

    before ->
      @CollectionMock = Backbone.Collection.extend(url: "/")
      @ItemViewMock = Backbone.View.extend()
      injector.mock
        "collections/todo": => @CollectionMock
        "views/item-view": => @ItemViewMock

    after ->
      injector.clean()

    setUpView = (done) ->
      injector.require ["views/list-view"], (ListView) =>
        @view = new ListView
        done()

    describe "#initialize", ->

      beforeEach (done) ->
        @fetchSpy = sinon.spy @CollectionMock::, "fetch"
        setUpView.call @, done

      afterEach ->
        @CollectionMock::fetch.restore()

      it "should be an instance of Backbone.View", ->
        expect(@view.cid).to.match /view/

      it "should fetch TODOs", ->
        expect(@fetchSpy.called).to.be.ok()
  
    describe "on collections' `reset`", ->

      beforeEach (done) ->
        @itemRenderSpy = sinon.spy @ItemViewMock::, "render"
        setUpView.call @, done

      afterEach ->
        @ItemViewMock::render.restore()
        
      it "should render item-views", ->
        @view.collection.reset [{ title: "hoge" }]
        expect(@itemRenderSpy.called).to.be.ok()
