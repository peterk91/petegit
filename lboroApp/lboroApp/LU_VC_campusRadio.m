//
//  LU_VC_campusRadio.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_campusRadio.h"

@interface LU_VC_campusRadio ()

@end

@implementation LU_VC_campusRadio

@synthesize theAppDelegate;
@synthesize imageView;
@synthesize helpImage;


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
    theAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playRadio:(id)sender {
    [self playselectedsong];
    imageView.image = [UIImage imageNamed:@"LU_pic_playing.png"];
    
}

- (IBAction)stopRadio:(id)sender {
    [theAppDelegate.audioPlayer pause];
    imageView.image = [UIImage imageNamed:@"LU_pic_stopped.png"];
    
}


-(void)playselectedsong{
    [theAppDelegate makeRadio];
    [theAppDelegate.audioPlayer play];
}

- (void) dealloc
{
    
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setHelpImage:nil];
    [super viewDidUnload];
}

- (IBAction)infoButton:(id)sender {
    if (helpImage.hidden == YES) {
        [helpImage setHidden:NO];
    }
    else{
        [helpImage setHidden:YES];
    }
    
}
@end
