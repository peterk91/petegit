//
//  LU_VC_secureWebView.m
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_secureWebView.h"

@interface LU_VC_secureWebView ()

@end

@implementation LU_VC_secureWebView

@synthesize websiteURL;
@synthesize webview, request, username, password;

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
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_printerLogin.php"];
    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    NSArray *variables = [NSArray arrayWithObjects: userid, nil];
    NSMutableArray *resultsPHP = [[sharedMethods alloc] connectPHPurl:url variables:variables];
    username = resultsPHP[0];
    password = resultsPHP[1];
    if([resultsPHP count] > 0){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://printpayments.lboro.ac.uk/safecom/"]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        webview.scalesPageToFit = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] > 0) {
        // do something may be alert message
    }
    else
    {
        NSURLCredential *credential = [NSURLCredential credentialWithUser:@"copk2"
                                                                 password:@"Password1"
                                                              persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }
    
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [webview loadRequest:request];
}

- (void)loadView;
{
    webview = [[UIWebView alloc] init];
    self.view = webview;
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


@end
