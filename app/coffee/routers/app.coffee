
define ["jquery"], ($) ->
  $(() ->
    debugger
    hello = $("<div/>")
    hello.html "Hello, world"
    $("body").append hello
  )

  () -> {}