//
//  LU_VC_settingsPopover.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_settingsPopover.h"

@interface LU_VC_settingsPopover ()

@end

@implementation LU_VC_settingsPopover



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
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popOverLOGOUT" object:self];
    //[self.delegate logOutPressed];
    
}

- (IBAction)membershipsPressed:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popOverMEMBER" object:self];
}

- (IBAction)faqPressed:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popOverFAQ" object:self];
}

- (IBAction)refreshEvents:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popOverREFRESH" object:self];
}

//@synthesize delegate;
@end
