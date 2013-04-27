var tests = Object.keys(window.__karma__.files).filter(function (file) {
  return /.*(specs|helpers).*\.js$/.test(file);
}).sort(function(lhs, rhs) {
  return lhs.match(/helper/) ? -1 : 1;
});

var paths = {
  "expect": "../vendor/expect/expect",
  "expect-chainge": "../vendor/expect-change/lib/expect-change",
  "Squire": "../vendor/Squire.js/src/Squire",
  "require": "../vendor/requirejs/require",
  "text": "../vendor/requirejs-text/text",
  "jquery": "../vendor/jquery/jquery",
  "underscore": "../vendor/underscore-amd/underscore",
  "backbone": "../vendor/backbone-amd/backbone",
  "chromeStorage": "../vendor/backbone.chromeStorage/backbone.chromestorage"
};

mocha.setup({ ignoreLeaks: true });

require.config({
  // Karma serves files from "/base"
  baseUrl: "/base/app/js",
  paths: paths,
  // ask requirejs to load these files (all our tests)
  deps: tests,
  // start test run, once requirejs is done
  callback: window.__karma__.start
});

require.config({
  context: "test",
  baseUrl: "/base/app/js",
  paths: paths
});

