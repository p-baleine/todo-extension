var tests = Object.keys(window.__karma__.files).filter(function (file) {
  return /.*specs.*\.js$/.test(file);
});

console.log(tests);

require({
  // Karma serves files from "/base"
  baseUrl: "/base/app/js",
  paths: {
    "expect": "../vendor/expect/expect",
    "require": "../vendor/requirejs/require",
    "jquery": "../vendor/jquery/jquery",
    "underscore": "../vendor/underscore-amd/underscore",
    "backbone": "../vendor/backbone-amd/backbone"
  },
  // ask requirejs to load these files (all our tests)
  deps: tests,
  // start test run, once requirejs is done
  callback: window.__karma__.start
});