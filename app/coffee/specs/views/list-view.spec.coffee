define [
  "backbone"
  "Squire"
], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "list-view", ->

    before ->
      @itemRenderSpy = sinon.spy -> @
      @ItemViewMock = sinon.spy Backbone.View.extend
        render: @itemRenderSpy
      injector.mock
        "views/item-view": => @ItemViewMock

    after ->
      injector.clean()

    beforeEach (done) ->
      @ItemViewMock.reset()
      @itemRenderSpy.reset()
      @todos = new Backbone.Collection [
        { title: "done 1", done: true }
        { title: "done 2", done: true }
        { title: "not done 1", done: false }
      ]
      injector.require ["views/list-view"], (ListView) =>
        @view = new ListView collection: @todos
        done()

    describe "todos `reset` event", ->

      it "should render", ->
        @todos.trigger "reset"
        expect(@view.$el).to.not.empty()

    describe "#render()", ->

      it "should render item-views", ->
        @view.render()
        expect(@itemRenderSpy.called).to.be.ok()

      it "should render all todos", ->
        @view.render()
        expect(@itemRenderSpy.callCount).to.equal 3

      describe "filter by `active`", ->

        it "should render only active todos" , ->
          @view.render "active"
          _(@ItemViewMock.args).each (arg) ->
            expect(arg[0].model.get("done")).to.be false

    describe "on collection's `add` event", ->

      beforeEach ->
        @view.render()

      it "should instantiate new ItemView with the added todo", ->
        @todos.add title: "new one"
        expect(@ItemViewMock.called).to.be.ok()
        expect(@ItemViewMock.lastCall.args[0]).to.have.property "model"
        expect(@ItemViewMock.lastCall.args[0].model.get("title")).to.equal "new one"

      it "should render the added todo"  , ->
        @todos.add title: "new one"
        expect(@itemRenderSpy.called).to.be.ok()
