//
//  VendorApps.h
//
// Created by Benjie Gillam on 2013-08-06.
//
// Copyright 2013 Benjie Gillam. All rights reserved.
// MIT Licensed

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface VendorApps : CDVPlugin

- (void)canOpenURL:(CDVInvokedUrlCommand*)command;

@end
