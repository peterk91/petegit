//
//  LU_VC_navController.m
//  lboroApp
//
//  Created by Peter Krepa on 15/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_navController.h"

@interface LU_VC_navController ()

@end

@implementation LU_VC_navController

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

- (BOOL)disablesAutomaticKeyboardDismissal {
    
    return NO;
}

@end
