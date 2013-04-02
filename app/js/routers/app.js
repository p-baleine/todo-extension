
define(['jquery'], function($) {
  $(function() {
    var hello = document.createElement("div");
    hello.innerHTML = "Hello, world";
    document.body.appendChild(hello);
  });

  return function() {};
});
