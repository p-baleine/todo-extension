
define [
  "backbone"
  "views/app-view"
], (Backbone, AppView) ->

  describe "app-view", ->

    beforeEach () ->
      @todos = new Backbone.Collection
      @todos.url = "/"
      @remainSpy = @todos.remain = sinon.spy(-> 3)
      @view = new AppView collection: @todos

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
