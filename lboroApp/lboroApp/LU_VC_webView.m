//
//  LU_VC_webView.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_webView.h"

@interface LU_VC_webView ()

@end

@implementation LU_VC_webView

@synthesize websiteURL;
@synthesize webview;
@synthesize request;
@synthesize needToolbar;
@synthesize pdfURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webview.scalesPageToFit = YES;;
    if(websiteURL){
        NSURL *url = [NSURL URLWithString:websiteURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        webview.scalesPageToFit = YES;
        [webview loadRequest:requestObj];
    }
    if(request){
        [webview loadRequest:request];
    }
    if(pdfURL){
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:pdfURL];
        webview.scalesPageToFit = YES;
        [webview loadRequest:requestObj];
    }

}

- (void)loadView;
{
    webview = [[UIWebView alloc] init];
    self.view = webview;
    
    if(needToolbar){
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 916, 768, 44)];
    [self.view addSubview:toolBar];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(webviewBack)];
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(webviewForward)];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(webviewRefresh)];
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(webviewStop)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttons = [NSArray arrayWithObjects: backButton,space,stopButton,space,refreshButton,space,forwardButton, nil];
    [toolBar setItems:buttons];
    }
    
}

-(void)webviewBack
{
    [webview goBack];
}
-(void)webviewForward
{
    [webview goForward];
}
-(void)webviewRefresh
{
    [webview reload];
}
-(void)webviewStop
{
    [webview stopLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
