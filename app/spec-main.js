var tests = Object.keys(window.__karma__.files).filter(function (file) {
  return /.*specs.*\.js$/.test(file);
  // return /.*specs.*list-view.js$/.test(file);
  //return /.*test.js$/.test(file);
});

require.config({
  // Karma serves files from "/base"
  baseUrl: "/base/app/js",
  paths: {
    "expect": "../vendor/expect/expect",
    "Squire": "../vendor/Squire.js/src/Squire",
    "require": "../vendor/requirejs/require",
    "text": "../vendor/requirejs-text/text",
    "jquery": "../vendor/jquery/jquery",
    "underscore": "../vendor/underscore-amd/underscore",
    "backbone": "../vendor/backbone-amd/backbone"
  },
  // ask requirejs to load these files (all our tests)
  deps: tests,
  // start test run, once requirejs is done
  callback: window.__karma__.start
});

require.config({
  context: "test",
  baseUrl: "/base/app/js",
  paths: {
    "expect": "../vendor/expect/expect",
    "Squire": "../vendor/Squire.js/src/Squire",
    "require": "../vendor/requirejs-text/require",
    "text": "../vendor/requirejs-text/text",
    "jquery": "../vendor/jquery/jquery",
    "underscore": "../vendor/underscore-amd/underscore",
    "backbone": "../vendor/backbone-amd/backbone"
  }
});
