###
@preserve
Brauhaus.js BeerXML Plugin
Copyright 2013 Daniel G. Taylor <danielgtaylor@gmail.com>
https://github.com/homebrewing/brauhausjs-beerxml
###

# Import Brauhaus if it hasn't already been defined
Brauhaus = @Brauhaus ? require 'brauhaus'

# Import DOM parser if needed to process BeerXML input
# Works in Node.js, Chrome, Firefox, IE9+, etc
DOMParser = window?.DOMParser ? require('xmldom').DOMParser
