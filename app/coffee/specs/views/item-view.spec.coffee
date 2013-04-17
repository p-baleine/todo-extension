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

      describe "when the status is not done", ->

        beforeEach (done) ->
          setUpView.call @, done, false

        it "should render done as not checked", ->
          expect(@view.render().$(".done").is(":checked")).to.not.be.ok()

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
