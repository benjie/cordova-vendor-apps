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

@end
