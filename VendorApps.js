/*
* VendorApps Plugin
*
* Copyright 2013 @Benjie Gillam
* MIT License
*/

(function(cordova){
  var VendorApps = function() {};
  var service = "VendorApps";

  VendorApps.prototype.canOpenURL = function(url, callback) {
    // Callback takes one argument, a boolean, in line with Node.js conventions
    var success = function(result) {
      callback(result);
    }
    var failure = function() {
      callback(false);
    }
    return cordova.exec(success, failure, service, 'canOpenURL', [url]);
  }

  cordova.addConstructor(function() {
    if (!window.plugins) window.plugins = {};
    window.plugins.vendorApps = new VendorApps();
  });

})(window.cordova || window.Cordova);