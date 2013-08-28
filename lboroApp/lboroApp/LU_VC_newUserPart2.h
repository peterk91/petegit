//
//  LU_VC_newUserPart2.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharedMethods.h"

@interface LU_VC_newUserPart2 : UIViewController
//outlets
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
//passed properties
@property NSString *username, *password, *passedFirstName, *passedLastName;
//actions
- (IBAction)registerPressed:(id)sender;
//Keyboard Dismissal
- (IBAction)backgroundTouch:(id)sender;
- (IBAction)textReturn:(id)sender;
@end
