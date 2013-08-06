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

`window.plugins.vendorApps.showApp(appId, callback)`

Call this with the app id (e.g. 300935801) to open either the iTunes URL
directly (multitasking) or if possible then an in-app StoreKit dialog.

Callback is called with one argument: error. If this is `undefined` then
the user was shown the app. We do not know if they installed it or not
(even if they did then the install is probably still in progress).
