//
//  VendorApps.m
//
// Created by Benjie Gillam on 2013-08-06.
//
// Copyright 2013 Benjie Gillam. All rights reserved.
// MIT Licensed

#import "VendorApps.h"

#ifndef BSGLog
#ifdef DEBUG
#   define BSGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define BSGLog(...)
#endif
#endif

@implementation VendorApps

- (void)canOpenURL:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;

    if ([command.arguments count] < 1) {
        BSGLog(@"VendorApps: No URL specified?");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No URL specified"];
    } else {
        NSString *URLString = [command.arguments objectAtIndex:0];
        NSURL *URL = [NSURL URLWithString:URLString];
        if (!URL) {
            BSGLog(@"VendorApps: Could not convert URLString to NSURL");
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid URL"];
        } else {
            BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:URL];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:canOpenURL ? 1 : 0];
        }
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openURL:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;

    if ([command.arguments count] < 1) {
        BSGLog(@"VendorApps: No URL specified?");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No URL specified"];
    } else {
        NSString *URLString = [command.arguments objectAtIndex:0];
        NSURL *URL = [NSURL URLWithString:URLString];
        if (!URL) {
            BSGLog(@"VendorApps: Could not convert URLString to NSURL");
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid URL"];
        } else {
            if ([[UIApplication sharedApplication] canOpenURL:URL]) {
                [[UIApplication sharedApplication] openURL:URL];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid URL"];
            }
        }
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)showApp:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;

    if ([command.arguments count] < 1) {
        BSGLog(@"VendorApps: No app ID specified?");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No app ID specified"];
    } else {
        NSString *appIdString = [command.arguments objectAtIndex:0];
        NSInteger appId = [appIdString integerValue];
        if (appId <= 0) {
            BSGLog(@"VendorApps: Invalid app ID '%@'", appIdString);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid application ID"];
        } else {
            if ([SKStoreProductViewController class]) {
                // StoreKit supported (iOS6+) - use it.
                SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
                storeViewController.delegate = self;
                NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier:@(appId)};
                [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
                    CDVPluginResult *pluginResult = nil;
                    if (result) {
                        self.showAppCallbackId = command.callbackId;
                        UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
                        [rootViewController presentViewController:storeViewController animated:YES completion:nil];
                    } else {
                        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Product not found in app store."];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    }
                }];
                return; // Prevent pluginResult sending again.
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/app/id%d", appId]]];
            }
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.showAppCallbackId];
    self.showAppCallbackId = nil;
}

@end
