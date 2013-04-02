//@ sourceMappingURL=app.map
(function() {
  define(["jquery"], function($) {
    $(function() {
      debugger;
      var hello;

      hello = $("<div/>");
      hello.html("Hello, world");
      return $("body").append(hello);
    });
    return function() {
      return {};
    };
  });

}).call(this);
