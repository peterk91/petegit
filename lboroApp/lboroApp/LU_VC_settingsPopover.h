//
//  LU_VC_settingsPopover.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LU_VC_loginPage.h"
/*
@protocol MyPopoverDelegate <NSObject>
-(void)logOutPressed;
@end*/

@interface LU_VC_settingsPopover : UIViewController

//@property (nonatomic, assign) id<MyPopoverDelegate> delegate;

- (IBAction)logOutPressed:(id)sender;
- (IBAction)membershipsPressed:(id)sender;
- (IBAction)faqPressed:(id)sender;
- (IBAction)refreshEvents:(id)sender;

@end
