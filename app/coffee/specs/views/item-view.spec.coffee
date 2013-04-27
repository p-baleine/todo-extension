define [
  "backbone"
  "Squire"
], (Backbone, Squire) ->

  describe "item-view", ->

    setUpView = (done, doneStatus = true) ->
      require ["views/item-view"], (ItemView) =>
        @model = new Backbone.Model title: "DailyJS", done: doneStatus
        @model.url = "/"
        @view = new ItemView model: @model
        done?()

    beforeEach (done) ->
      setUpView.call @, done

    it "should be an instance of Backbone.View", ->
      expect(@view).to.be.a Backbone.View

    it "should has `todo-item` as its class name", ->
      expect(@view.$el.hasClass "todo-item").to.be.ok()

    describe "#render", ->

      it "should render title", ->
        expect(@view.render().$el.html()).to.contain @model.get("title")

      it "should `li` as its tagName", ->
        expect(@view.render().el.tagName).to.match /li/i

      describe "when the status is done", ->

        it "should render done as checked", ->
          expect(@view.render().$(".done").is(":checked")).to.be.ok()

        it "should add `done` class to el", ->
          expect(@view.render().$el.hasClass("done")).to.be.ok()

      describe "when the status is not done", ->

        beforeEach (done) ->
          setUpView.call @, done, false

        it "should render done as not checked", ->
          expect(@view.render().$(".done").is(":checked")).to.not.be.ok()

    describe "make editable on dblclick", ->

      beforeEach ->
        @view.render()

      it "should add `editable` class to el", ->
        @view.$(".view").trigger("dblclick")
        expect(@view.$el.hasClass("editable")).to.be.ok()

    describe "update todo", ->

      beforeEach (done) ->
        setUpView.call @, =>
          @saveSpy = sinon.spy @model, "save"
          @view.render()
          @view.$el.addClass "editable"
          @content = "update content"
          @view.$(".edit").val "update content"
          @event = Backbone.$.Event "keydown"
          @event.keyCode = 13
          @preventDefaultSpy = sinon.spy @event, "preventDefault"
          done()

      afterEach ->
        @model.save.restore()
        @event.preventDefault.restore()

      describe "when enter key pressed", ->
  
        it "should suspend event's default behavior", ->
          @view.$(".edit").trigger @event
          expect(@preventDefaultSpy.called).to.be.ok()
        
        it "should save model with new content", ->
          @view.$(".edit").trigger @event
          expect(@saveSpy.called).to.be.ok()
          expect(@saveSpy.lastCall.args[0]).to.have.property "title", @content
  
        it "should remove `editable` class from el", ->
          expect(=> @view.$(".edit").trigger @event)
            .to.change(=> @view.$el.hasClass("editable")).from(on).to(off)

      describe "when key pressed other than enter key", ->

        beforeEach ->
          @event.keyCode = 12
  
        it "should not suspend event's default behavior", ->
          @view.$(".edit").trigger @event
          expect(@preventDefaultSpy.called).to.not.be.ok()
  
    describe "make done", ->

      beforeEach (done) ->
        setUpView.call @, =>
          @saveSpy = sinon.spy @model, "save"
          @view.render()
          expect(@view.$(".done").is(":checked")).to.not.be.ok()
          done()
        , false

      afterEach ->
        @model.save.restore()

      it "should save model with done status true", ->
        @view.$(".done").prop "checked", true
        @view.$(".done").change()
        expect(@saveSpy.called).to.be.ok()
        expect(@saveSpy.lastCall.args[0]).to.have.property "done", true

      it "should add class `done` to el", ->
        expect(=>
          @view.$(".done").prop "checked", true
          @view.$(".done").change()
        ).to.change(=> @view.$el.hasClass("done")).from(off).to(on)

    describe "delete", ->

      beforeEach (done) ->
        setUpView.call @, =>
          @destroySpy = sinon.spy @model, "destroy"
          @view.render().$el.appendTo "body"
          expect(@view.$el.closest("html")).to.not.empty()
          done()

      afterEach ->
        @model.destroy.restore()

      it "should destroy deleted model", ->
        @view.$(".destroy").click()
        expect(@destroySpy.called).to.be.ok()

      it "should remove deleted todo view", ->
        expect(=> @view.$(".destroy").click())
          .to.change(=> @view.$el.closest("html").length).to 0
