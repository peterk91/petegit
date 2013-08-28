//
//  LU_VC_loginPage.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharedMethods.h"
#import "AppDelegate.h"
#import "Module.h"
#import "AUClub.h"
#import "Society.h"
#import "LabelEdition.h"
#import "LU_VC_membershipPage.h"

@interface LU_VC_loginPage : UIViewController
//outlets
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
//properties
@property UIView *loadingView;
//actions
- (IBAction)loginPressed:(id)sender;
- (IBAction)newUserPressed:(id)sender;
//Keyboard Dismissal
- (IBAction)backgroundTouch:(id)sender;
- (IBAction)textReturn:(id)sender;
@end
