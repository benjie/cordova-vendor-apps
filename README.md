VendorApps
==========

This Cordova (PhoneGap, >= v2.1.0) plugin allows you to quickly and
easily integrate with your other apps (or those of third parties) using
URL schemes.

Methods:
--------

`window.plugins.vendorApps.canOpenURL(url, callback)`

Call this with a URL (e.g. "myappscheme://") and the callback is called
with one argument: true if the scheme is supported, false otherwise (it
uses `[[UIApplication sharedApplication] canOpenURL:]` internally, thus
it's name).
