# TODO Chrome Extension

TODO app for Chrome Extension.

![screenshot](https://raw.github.com/p-baleine/todo-extension/master/screenshot.png)

This app is written for the purpose of my studying
Chrome Extension, Backbone.js, RequireJS, Bower.

## How to use it

### Setup

Install dependencies:

```bash
$ sudo npm install -g grunt-cli
$ sudo npm install -g bower
$ bower install
$ npm install
```

Then compile coffeescripts and copy templates:

```bash
$ grunt coffee
$ grunt copy
```

### Load package

* In Google Chrome, go to chrome://flags/ and enable Experimental Extension APIs. Relaunch your browser.

* Open Tools-->Extensions (ensure Development mode is checked) and click on "Load unpacked extension..." to install the extension. You will need to reload Chrome once the extension is installed.

## Developmetn

### Start

```bash
$ grunt watch
$ grunt karma # in another tab
```

Then start BDD!
