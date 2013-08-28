//
//  LU_VC_setupPage.m
//  lboroApp
//
//  Created by Peter Krepa on 16/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_setupPage.h"

@interface LU_VC_setupPage ()

@end

@implementation LU_VC_setupPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}
//when the end button is pressed the view is dismissed and the end setup notification is sent to the notification centre
- (IBAction)endSetup:(id)sender{
        [self dismissModalViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endSetup" object:self];
}
@end
