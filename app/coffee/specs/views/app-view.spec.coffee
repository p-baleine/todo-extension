
define [
  "backbone"
  "Squire"
], (Backbone, Squire) ->

  injector = new Squire "test"

  describe "app-view", ->

    before ->
      @ListViewMock = sinon.spy Backbone.View.extend()
      injector.mock
        "views/list-view": => @ListViewMock

    after ->
      injector.clean()

    beforeEach (done) ->
      injector.require ["views/app-view"], (AppView) =>
        @todos = new Backbone.Collection
        @todos.url = "/"
        @remainSpy = @todos.remain = sinon.spy(-> 3)
        @view = new AppView collection: @todos
        done()

    afterEach ->
      @ListViewMock.reset()

    it "should be an instance of Backbone.View", ->
      expect(@view.cid).to.match /view/

    describe "todos `reset` event", ->

      it "should render", ->
        @todos.trigger "reset"
        expect(@view.$el).to.not.empty()

    describe "#render()", ->

      it "should render `#list-container`", ->
        expect(@view.render().$("#list-container")).to.not.empty()

      it "should render input for new todo item", ->
        expect(@view.render().$("input[name=new-item]")).to.not.empty()

      it "should query remain items count to collection", ->
        @view.render()
        expect(@remainSpy.called).to.be.ok()

      it "should render remain items count", ->
        expect(@view.render().$("#remain").text()).to.contain(3)      

      it "should instantiate ListView", ->
        @view.render()
        expect(@ListViewMock.called).to.be.ok()

      it "should pass `#list-container` to ListView as `el`", ->
        @view.render()
        expect(@ListViewMock.lastCall.args[0]).to.have.property "el"
        expect(@ListViewMock.lastCall.args[0].el.attr("id")).to.equal "list-container"

      it "should pass `todos` to ListView as `collection`", ->
        @view.render()
        expect(@ListViewMock.lastCall.args[0]).to.have.property "collection"
        expect(@ListViewMock.lastCall.args[0].collection).to.equal(@view.collection)

    describe "create new todo item", ->

      beforeEach ->
        @createSpy = sinon.spy @todos, "create"
        @title = "Read DailyJS"
        @event = Backbone.$.Event "keydown"
        @event.keyCode = 13
        @preventDefaultSpy = sinon.spy @event, "preventDefault"
        @view.render()
        @view.$("[name=new-item]").val @title

      afterEach ->
        @event.preventDefault.restore()
        @todos.create.restore()

      describe "when enter key pressed", ->
  
        it "should suspend event's default behavior", ->
          @view.$("[name=new-item]").trigger @event
          expect(@preventDefaultSpy.called).to.be.ok()

        it "should create todo via @todos", ->
          @view.$("[name=new-item]").trigger @event
          expect(@createSpy.called).to.be.ok()

        it "should create todo with input title", ->
          @view.$("[name=new-item]").trigger @event
          expect(@createSpy.lastCall.args[0]).to.have.property "title", @title

        it "should clear input after creation of todo", ->
          @view.$("[name=new-item]").trigger @event
          expect(@view.$("[name=new-item]").val()).to.be.empty()

      describe "when key pressed other than enter key", ->

        beforeEach ->
          @event.keyCode = 12
  
        it "should not suspend event's default behavior", ->
          @view.$("[name=new-item]").trigger @event
          expect(@preventDefaultSpy.called).to.not.be.ok()

    describe "update remain count", ->

      setUpView = (remainCount) ->
        @view.render()
        @remainSpy = @todos.remain = sinon.spy(-> remainCount)


      describe "collection's `change-remain` event", ->

        beforeEach ->
          setUpView.call @, 5

        it "should update remain items count", ->
          @todos.trigger "change-remain"
          expect(@view.$("#remain").text()).to.contain(5)

      describe "collection's `add` event", ->

        beforeEach ->
          setUpView.call @, 6

        it "should update remain items count", ->
          @todos.trigger "add"
          expect(@view.$("#remain").text()).to.contain(6)

      describe "collection's `remove` event", ->

        beforeEach ->
          setUpView.call @, 4

        it "should update remain items count", ->
          @todos.trigger "remove"
          expect(@view.$("#remain").text()).to.contain(4)
