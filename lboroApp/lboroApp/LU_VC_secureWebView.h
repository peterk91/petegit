//
//  LU_VC_secureWebView.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharedMethods.h"

@interface LU_VC_secureWebView : UIViewController<NSURLConnectionDelegate>

@property (strong, nonatomic) UIWebView *webview;
@property (copy, nonatomic) NSString *websiteURL, *username, *password;
@property NSURLRequest *request;

@end
