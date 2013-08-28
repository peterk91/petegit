//
//  LU_VC_webView.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LU_VC_webView : UIViewController

@property (strong, nonatomic) UIWebView *webview;
@property (copy, nonatomic) NSString *websiteURL;
@property NSURL *pdfURL;
@property NSMutableURLRequest *request;
@property BOOL needToolbar;

@end
