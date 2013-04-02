
define ["jquery", "routers/app"], ($, AppRouter) ->

  describe "AppRouter", () ->
    router = new AppRouter

    describe "#index()", () ->
      it "should append `hello` text to body", () ->
        router.index()
        expect($("body").html()).to.contain "Hello, world!!!"