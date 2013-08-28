//
//  LU_VC_loginPage.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_loginPage.h"

@interface LU_VC_loginPage ()

@end

@implementation LU_VC_loginPage
//outlets
@synthesize username,password;
//properties
@synthesize loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //when launched the user defaults are checked to see if the user has left the system in a logged in state if so then auto login process begins after a delay. delay allows time for the view to finish initialising before starting a new animation.
    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *loggedin = [currentUserDefaults stringForKey:@"loggedin"];
    [currentUserDefaults synchronize];
    if([loggedin isEqualToString:@"1"])
    {
        [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(login:) userInfo:nil repeats:NO];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [self setUsername:nil];
    [self setPassword:nil];
    [super viewDidUnload];
}

//fires when the login button is pressed
- (IBAction)loginPressed:(id)sender{
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_login.php"];
    NSArray *variables = [NSArray arrayWithObjects: username.text,password.text, nil];
    NSMutableArray *resultsPHP = [[sharedMethods alloc] connectPHPurl:url variables:variables];
    //the result contains a pass/fail number which indicates the pass or type of fail. if its a pass then array also contains the database userid
    NSInteger accessResult = [resultsPHP[0] intValue];
    if (accessResult > 0){
        [self loadAnimation:4];
        //if the credentials are vaild the database userid is added to the user defaults the logged in default is set to 1
        NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
        [currentUserDefaults setObject:resultsPHP[1] forKey:@"userid"];
        [currentUserDefaults setObject:@"1" forKey:@"loggedin"];
        //the user defaults are used to store the current userid a variable logged in is used to see if the app has been used before. if the app has not been used, or this user has never logged in on any device, then the setup screen appears the necessary data is collected to allow for the setup
        if(![currentUserDefaults stringForKey:@"firstTime"] || [resultsPHP[2] isEqualToString:@"0"] ) {
            [currentUserDefaults setObject:@"1" forKey:@"firstTime"];
            [currentUserDefaults synchronize];
            [[sharedMethods alloc] getAllOptions];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSetupComplete) name:@"endSetup" object:nil];
            [self performSegueWithIdentifier:@"setupSegue" sender:sender];
            username.text = @"";
            password.text = @"";
        }
        //if the setup has been done then the homepage is presented. the nessesary data is collected for this to happen.
        else{
            [currentUserDefaults synchronize];
            [self login:NO];
            username.text = @"";
            password.text = @"";
        }
    }
    //if there is an error an alert is displayed with an appropiate message
    else {
        NSString *alertStr = [NSString new];
        if (accessResult==-1){
            alertStr=@"Incorrect password";
        }
        if (accessResult==-2){
            alertStr=@"The username you entered was either incorrect or not registered to use this app. To register please click the new user button";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:alertStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        password.text = @"";
    }
}

//called when the user setup has finished. it removes the observer and then processes the autologin
-(void)userSetupComplete{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"endSetup" object:nil];
    [self login:YES];
}

//this method provides a load animation the length is set by the delay integer
-(void)loadAnimation:(NSInteger)delay{
    //creates a black view
    CGRect myframe = self.view.frame;
    loadingView = [[UIView alloc] initWithFrame:myframe];
    loadingView.backgroundColor = [UIColor blackColor];
    //gives it transparancy
    loadingView.alpha = .7;
    //adds it as the subview
    [self.view.window addSubview:loadingView];
    //beginds the animation
    [UIView beginAnimations:nil context:nil];
    //the animation will start after 1.2 seconds and last 1.2seconds
    [UIView setAnimationDuration:delay];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view.window cache:YES];
    //passes the current context to when the animation is complete
    [UIView setAnimationDidStopSelector:@selector(loginAnimationDone)];
    [UIView setAnimationDelegate:self];
    //end of animation will make the view transparent
    loadingView.alpha = 0.0;
    [UIView commitAnimations];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    CGPoint currentCentre = self.view.center;
    activityIndicator.center = currentCentre;
    activityIndicator.hidesWhenStopped = YES;
    [loadingView addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

//this function is called when login is pressed or when the login was left in a logged in state
-(void)login:(BOOL)autoLogin{
    if(autoLogin){
    [self loadAnimation:3];}
    [[sharedMethods alloc] getAllOptions];
    [[sharedMethods alloc] getLabelData];
    [[sharedMethods alloc] getTVData];
    [self performSegueWithIdentifier:@"mainNavConSegue" sender:self];
}

//when the animation is done the top view is removed
- (void)loginAnimationDone{
    [loadingView removeFromSuperview];
}

//called when the new user button is pressed. Presents the new user 1 segue.
- (IBAction)newUserPressed:(id)sender{
     [self performSegueWithIdentifier:@"newUser1Segue" sender:self];
}

//keyboard dismissal
- (BOOL)disablesAutomaticKeyboardDismissal {return NO;}
- (IBAction)textReturn:(id)sender {[sender resignFirstResponder];}
- (IBAction)backgroundTouch:(id)sender {[self.parentViewController.view endEditing:YES];}
@end
