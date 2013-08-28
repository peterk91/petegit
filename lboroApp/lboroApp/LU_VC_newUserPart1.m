//
//  LU_VC_newUserPart1.m
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_newUserPart1.h"

@interface LU_VC_newUserPart1 ()

@end

@implementation LU_VC_newUserPart1
//outlets
@synthesize username, password;
//properties
@synthesize firstName, lastName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self setUsername:nil];
    [self setPassword:nil];
    [super viewDidUnload];
}

//when the Enter button is pressed this method sends the input from the username and password text fields to a php files which checks their vaildity
- (IBAction)enterPressed:(id)sender{
    //sent using shared method connectPHPurl
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_userCheck.php"];
    NSArray *variables = [NSArray arrayWithObjects: username.text,password.text, nil];
    NSMutableArray *resultsPHP = [[sharedMethods alloc] connectPHPurl:url variables:variables];
    //the result is an array with one or three string object(s). One if an error is sent and three if confirmation of vaildity is sent. The first string represents the pass/fail. The second and third are the first and last names of the user.
    if([resultsPHP[0] isEqualToString:@"pass"]) {
        //the first and last names are saved to object to be sent to the next view
        firstName = resultsPHP[1];
        lastName = resultsPHP[2];
        [self performSegueWithIdentifier:@"newUser2Segue" sender:self];
        username.text = @"";
        password.text = @"";
    }
    if([resultsPHP[0] isEqualToString:@"fail1"]) {
        //an error detailing the alert is displayed
        NSString *msg=@"The username you specified is already registered for this app";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        username.text = @"";
        password.text = @"";
    }
    if([resultsPHP[0] isEqualToString:@"fail2"]) {
        //an error detailing the alert is displayed
        NSString *msg=@"The credentials you entered do not match an existing Loughborough account. Please verify you entered all details correctly.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        password.text = @"";
    }
}

//fires when cancel is pressed. simply dismisses the view
- (IBAction)cancelPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

//performed when vaild credentials are entered and the segue to the next view is started. It passes the required fields to the next view.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"newUser2Segue"]) {
        LU_VC_newUserPart2 *newController =  [segue destinationViewController];
        newController.passedFirstName = firstName;
        newController.passedLastName = lastName;
        newController.username = username.text;
        newController.password = password.text;
    }
}

//keyboard dismissal
- (BOOL)disablesAutomaticKeyboardDismissal {return NO;}
- (IBAction)textReturn:(id)sender {[sender resignFirstResponder];}
- (IBAction)backgroundTouch:(id)sender {[self.parentViewController.view endEditing:YES];}
@end
