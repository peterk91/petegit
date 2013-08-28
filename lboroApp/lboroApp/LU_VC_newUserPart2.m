//
//  LU_VC_newUserPart2.m
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_newUserPart2.h"

@interface LU_VC_newUserPart2 ()

@end

@implementation LU_VC_newUserPart2
//outlets
@synthesize firstName, lastName, emailAddress;
//passed properties
@synthesize username, password, passedFirstName, passedLastName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //sets fields to passed variables
    firstName.text = passedFirstName;
    lastName.text = passedLastName;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmailAddress:nil];
    [super viewDidUnload];
}

- (IBAction)registerPressed:(id)sender{
    //error checking on entered fields
    NSMutableString *alertStr = [NSMutableString new];
    NSRange nameRange2 = [emailAddress.text rangeOfString:@"@" options:NSCaseInsensitiveSearch];
    BOOL validEmail = !(nameRange2.location == NSNotFound);
    BOOL validName = ![firstName.text isEqualToString:@""];
    BOOL validLast = ![lastName.text isEqualToString:@""];
    //if fields vaild then details are passed to php file and user is registered
    if(validEmail && validName && validLast) {
        NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_createNewUser.php"];
        NSArray *variables = [NSArray arrayWithObjects: username,password,firstName.text,lastName.text,emailAddress.text, nil];
        [[sharedMethods alloc] connectPHPurl:url variables:variables];
        [alertStr appendString:@"You have registered. Please continue to login with your Loughborough University credentials"];
        [self dismissModalViewControllerAnimated:YES];
    }
    //if not vaild an alert will be displayed detailing the error(s)
    else{
        if(!validName){
            [alertStr appendString:@"\n-You have not entered a first name"];
        }
        if(!validLast){
            [alertStr appendString:@"\n-You have not entered a last name"];
        }
        if(!validEmail){
            [alertStr appendString:@"\n-You have not entered a valid email address"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:alertStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [alert show];
}

//keyboard dismissal
- (BOOL)disablesAutomaticKeyboardDismissal {return NO;}
- (IBAction)textReturn:(id)sender {[sender resignFirstResponder];}
- (IBAction)backgroundTouch:(id)sender {[self.parentViewController.view endEditing:YES];}
@end
