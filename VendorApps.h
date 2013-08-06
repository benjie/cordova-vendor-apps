//
//  VendorApps.h
//
// Created by Benjie Gillam on 2013-08-06.
//
// Copyright 2013 Benjie Gillam. All rights reserved.
// MIT Licensed

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <StoreKit/StoreKit.h>

@interface VendorApps : CDVPlugin <SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) NSString *showAppCallbackId;

- (void)canOpenURL:(CDVInvokedUrlCommand*)command;
- (void)openURL:(CDVInvokedUrlCommand*)command;
- (void)showApp:(CDVInvokedUrlCommand*)command;

@end
