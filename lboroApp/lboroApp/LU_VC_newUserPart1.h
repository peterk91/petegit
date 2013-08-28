//
//  LU_VC_newUserPart1.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharedMethods.h"
#import "LU_VC_newUserPart2.h"

@interface LU_VC_newUserPart1 : UIViewController
//outlets
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
//properties
@property NSString *firstName, *lastName;
//actions
- (IBAction)cancelPressed:(id)sender;
- (IBAction)enterPressed:(id)sender;
//Keyboard Dismissal
- (IBAction)backgroundTouch:(id)sender;
- (IBAction)textReturn:(id)sender;
@end
