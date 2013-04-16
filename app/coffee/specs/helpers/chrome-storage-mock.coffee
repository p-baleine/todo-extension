
window.chrome ?= {}
return if window.chrome.storage?

window.chrome.storage =
  clear: ->,
  get: ->,
  set: ->,
  remove: ->,
