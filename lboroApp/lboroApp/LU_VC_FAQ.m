//
//  LU_VC_FAQ.m
//  lboroApp
//
//  Created by Peter Krepa on 22/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_FAQ.h"

@interface LU_VC_FAQ ()

@end

@implementation LU_VC_FAQ

@synthesize navBar, webView;

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
    UIBarButtonItem *item = [[UIBarButtonItem alloc]    initWithTitle:@"Done"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(closePressed:)];
    
    [navBar setRightBarButtonItem:item];
    
    webView.scalesPageToFit = YES;;
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_FAQ.html"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setNavBar:nil];
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
