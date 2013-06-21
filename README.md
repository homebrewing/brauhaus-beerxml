Brauhaus.js BeerXML Plugin
==========================
[![Dependency Status](https://gemnasium.com/danielgtaylor/brauhaus-beerxml.png)](https://gemnasium.com/danielgtaylor/brauhaus-beerxml) [![Build Status](https://travis-ci.org/homebrewing/brauhaus-beerxml.png)](https://travis-ci.org/homebrewing/brauhaus-beerxml) [![Coverage Status](https://coveralls.io/repos/homebrewing/brauhaus-beerxml/badge.png?branch=master)](https://coveralls.io/r/homebrewing/brauhaus-beerxml?branch=master) [![NPM version](https://badge.fury.io/js/brauhaus-beerxml.png)](http://badge.fury.io/js/brauhaus-beerxml)

A plugin for [Brauhaus.js](https://github.com/homebrewing/brauhausjs) that adds [BeerXML 1.0](http://www.beerxml.com/) import and export capabilities. Features include:

 * Support for multiple Javascript runtimes
   * [Node.js](http://nodejs.org/) 0.8.19+, 0.10.x
   * Chrome, Firefox, Internet Explorer 9+, Safari, Opera, etc
 * BeerXML 1.0 import / export
 * About 12kb when minified

Interactive Examples
--------------------

 * [BeerXML import (Coffeescript)](http://jsfiddle.net/danielgtaylor/6cj3N/)

Installation
------------
There are two ways to use Brauhaus.js - either in a web browser (client-side) or on e.g. Node.js (server-side).

### Web Browser (client-side use)
To use Brauhaus.js in a web browser, simply download the following files and include them as you would any other script:

 * [Download the latest brauhaus.min.js](https://raw.github.com/homebrewing/brauhausjs/master/dist/brauhaus.min.js)
 * [Download the latest brauhaus-beerxml.min.js](https://raw.github.com/homebrewing/brauhaus-beerxml/master/dist/brauhaus-beerxml.min.js)

```html
<script type="text/javascript" src="/scripts/brauhaus.min.js"></script>
<script type="text/javascript" src="/scripts/brauhaus-beerxml.min.js"></script>
<script type="text/javascript">
    // Your code goes here!
    // See below for an example...
</script>
```

### Node.js (server-side use)
For Node.js, you can easily install Brauhaus.js using `npm`:

```bash
npm install brauhaus-beerxml
```

Quick Example (Import)
----------------------

```javascript
// The following lines are NOT required for web browser use
var Brauhaus = require('brauhaus');
require('brauhaus-beerxml');

var beerxml = '<recipes><recipe><name>Test Recipe</name>...</recipe></recipes>';

// Get a list of recipes
var recipes = Brauhaus.Recipe.fromBeerXml(beerxml);

console.log('There are ' + recipes.length + ' recipes.');

var r = recipes[0];

console.log('The first recipe is named ' + r.name);
```

Quick Example (Export)
----------------------

```javascript
// The following lines are NOT required for web browser use
var Brauhaus = require('brauhaus');
require('brauhaus-beerxml');

// Create a recipe
var r = new Brauhaus.Recipe({
    name: 'My test brew',
    description: 'A new test beer using Brauhaus.js!',
    batchSize: 20.0,
    boilSize: 10.0
});

// Add ingredients
r.add('fermentable', {
    name: 'Extra pale malt',
    color: 2.5,
    weight: 4.2,
    yield: 78.0
});

r.add('hop', {
    name: 'Cascade hops',
    weight: 0.028,
    aa: 5.0,
    use: 'boil',
    form: 'pellet'
});

r.add('yeast', {
    name: 'Wyeast 3724 - Belgian Saison',
    type: 'ale',
    form: 'liquid',
    attenuation: 80
});

// Set up a simple infusion mash
r.mash = new Brauhaus.Mash({
    name: 'My mash',
    ph: 5.4
});

r.mash.addStep({
    name: 'Saccharification',
    type: 'Infusion',
    time: 60,
    temp: 68,
    waterRatio: 2.75
});

// Print out BeerXML for the recipe
console.log(r.toBeerXml())
```

Brauhaus.Recipe
---------------
A beer recipe, containing ingredients like fermentables, spices, and yeast. Calculations can be made for bitterness, alcohol content, color, and more.

### Recipe.fromBeerXml (xml)
Get a list of recipes from BeerXML loaded as a string.

```javascript
>>> xml = '<recipes><recipe><name>Test Recipe</name>...</recipe></recipes>'
>>> recipe = Brauhaus.Recipe.fromBeerXml(xml)[0]
<Brauhaus.Recipe object 'Test Recipe'>
```

---

### Recipe.prototype.toBeerXml ()
Convert this recipe into BeerXML for export. Returns a BeerXML string.

```javascript
>>> recipe.toBeerXml()
'<?xml version="1.0"><recipes><recipe>...</recipe></recipes>'
```

Contributing
------------
Contributions are welcome - just fork the project and submit a pull request when you are ready!

### Getting Started
First, create a fork on GitHub. Then:

```bash
git clone ...
cd brauhaus-beerxml
npm install
```

### Style Guide
Brauhaus uses the [CoffeeScript Style Guide](https://github.com/polarmobile/coffeescript-style-guide) with the following exceptions:

 1. Indent 4 spaces
 1. Maximum line length is 120 characters

When building `brauhaus.js` with `cake build` or `npm test` you will see the output of [CoffeeLint](http://www.coffeelint.org/), a static analysis code quality tool for CoffeeScript. Please adhere to the warnings and errors to ensure your changes will build.

### Unit Tests
Before submitting a pull request, please add any relevant tests and run them via:

```bash
npm test
```

If you have PhantomJS installed and on your path then you can use:

```bash
CI=true npm test
```

Pull requests will automatically be tested by Travis CI both in Node.js 0.6/0.8/0.10 and in a headless webkit environment (PhantomJS). Changes that cause tests to fail will not be accepted. New features should be tested to be accepted.

New tests can be added in the `test` directory. If you add a new file there, please don't forget to update the `test.html` to include it!

### Code Coverage
You can generate a unit test code coverage report for unit tests using the following:

```bash
cake coverage
```

You can find an HTML report in the `coverage` directory that is created. This report will show line-by-line code coverage information.

---

Please note that all contributions will be licensed under the MIT license in the following section.

License
-------
Copyright (c) 2013 Daniel G. Taylor

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
