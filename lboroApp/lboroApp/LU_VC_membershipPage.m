//
//  LU_VC_membershipPage.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_membershipPage.h"

@interface LU_VC_membershipPage ()

@end

@implementation LU_VC_membershipPage
//outlets
@synthesize addMod, addAU, addSoc, memberTableView, helpImage;
//properties
@synthesize addType, optionsArray, managedObjectContext, typePassing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //find out the parent view controller as this page can be accessed from the setup or the settings page
    NSString *from = self.parentViewController.title;
    if([from isEqualToString:@"fromHome"]){
        UIBarButtonItem *item = [[UIBarButtonItem alloc]    initWithTitle:@"Done"
                                                            style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(saveChanges)];

        [self.navigationItem setRightBarButtonItem:item];
    }
    //get the memberships
    [self getMyMemberships];
    [[sharedMethods alloc] getEventData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    [self setAddMod:nil];
    [self setAddAU:nil];
    [self setAddSoc:nil];
    [self setMemberTableView:nil];
    [self setHelpImage:nil];
    [super viewDidUnload];
}
//this method gets all the memberships that the user has and then creates an array with the objects
-(void)getMyMemberships{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    //gets all the membership options where chosen is 1 meaning that the student is a memeber
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(chosen LIKE '1')"];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
    NSFetchRequest *request3 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"AUClub" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *entity3 = [NSEntityDescription entityForName:@"Society" inManagedObjectContext:managedObjectContext];
    [request1 setEntity:entity1];
    [request1 setPredicate:predicate];
    [request2 setEntity:entity2];
    [request2 setPredicate:predicate];
    [request3 setEntity:entity3];
    [request3 setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request1 setSortDescriptors:sortDescriptors];
    [request2 setSortDescriptors:sortDescriptors];
    [request3 setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
    }
    NSMutableArray *mutableFetchResults2= [[managedObjectContext executeFetchRequest:request2 error:&error] mutableCopy];
    if (mutableFetchResults2 == nil) {
    }
    NSMutableArray *mutableFetchResults3 = [[managedObjectContext executeFetchRequest:request3 error:&error] mutableCopy];
    if (mutableFetchResults3 == nil) {
    }
    optionsArray = [NSMutableArray new];
    //each array is put into another array allows sections to the allocated later
    [optionsArray addObject:mutableFetchResults1];
    [optionsArray addObject:mutableFetchResults2];
    [optionsArray addObject:mutableFetchResults3];
}

//this happens when one of the app buttons is pressed. the button pressed is calcluated and the value add type is set. the add option sege is then performed
- (IBAction)addOption:(id)sender{
    //a notification observer is set up to refresh the table whenever the notification is output, this happens when a new membership is added
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"reloadTable" object:nil];
    if (sender==addMod)
        addType = @"MOD";
    if (sender==addAU)
        addType = @"AU";
    if (sender==addSoc)
        addType = @"SOC";
    [self performSegueWithIdentifier:@"addOptionSegue" sender:sender];
}

//this is called via the notification centre. It allows the add option page to notifty the controller to refresh the table and then to stop observing for the notifcation 
- (void)refreshTable{
    [[sharedMethods alloc] getEventData];
    [self getMyMemberships];
    [memberTableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadTable" object:nil];
}

//fired when the next button is pressed. only displayed if in setup mode.
- (IBAction)nextPressed:(id)sender{
    [self performSegueWithIdentifier:@"finalSetupSegue" sender:self];
}
//controls the help post it appearing and disappearing
- (IBAction)infoButton:(id)sender {
    if (helpImage.hidden == YES) {
        [helpImage setHidden:NO];
    }
    else{
        [helpImage setHidden:YES];
    }
}

//this happens when save is pressed
-(void)saveChanges{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshDayInfo" object:self];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //when the add option segue fires the new view controllers add type property is set to the type of event being added
    if ([[segue identifier] isEqualToString:@"addOptionSegue"])
    {
        LU_VC_addOption *newController =  [segue destinationViewController];
        newController.addType = addType;
    }
}

//table setup
#pragma mark - Table view data source
//configures the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [optionsArray count];
}

//configures the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *options = [optionsArray objectAtIndex:section];
    return [options count];
}

//configures the section titles
- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *options = [optionsArray objectAtIndex:section];
    NSInteger count = [options count];
    if (section == 0)
        return @"Modules (Select an option to edit events)";
    else if (section == 1 && count !=0)
        return @"AU Clubs (Select an option to edit events)";
    else if (section == 2 && count !=0)
        return @"Societies (Select an option to edit events)";
    else
        return nil;
}

//configures the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"membershipCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *options = [optionsArray objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        Module *current = [options objectAtIndex:indexPath.row];
        cell.textLabel.text = current.title;
    }
    if (indexPath.section == 1) {
        AUClub *current = [options objectAtIndex:indexPath.row];
        cell.textLabel.text = current.title;
    }
    if (indexPath.section == 2) {
        Society *current = [options objectAtIndex:indexPath.row];
        cell.textLabel.text = current.title;
    }
    return cell;
}

//allows deletion of rows
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//specifies what happes when a row is deleted
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *options = [optionsArray objectAtIndex:indexPath.section];
        NSError *error = nil;
        //the chosen property is set to 0
        if (indexPath.section == 0){
            Module *currentChoice = [options objectAtIndex:indexPath.row];
            [currentChoice setValue:@"0" forKey:@"chosen"];
            [[sharedMethods alloc] updateUserMOD:currentChoice toDelete:YES];
        }
        if (indexPath.section == 1){
            AUClub *currentChoice = [options objectAtIndex:indexPath.row];
            [currentChoice setValue:@"0" forKey:@"chosen"];
            [[sharedMethods alloc] updateUserAU:currentChoice toDelete:YES];
        }
        if (indexPath.section == 2){
            Society *currentChoice = [options objectAtIndex:indexPath.row];
            [currentChoice setValue:@"0" forKey:@"chosen"];
            [[sharedMethods alloc] updateUserSOC:currentChoice toDelete:YES];
        }
        //the change is saved to the core data
        if(![managedObjectContext save:&error])
            NSLog(@"data cannot be saved");
        //the row is removed for the table
        [options removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//specifies what happens when a row is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        typePassing = @"MOD";
    }
    if(indexPath.section == 1){
        typePassing = @"AU";
    }
    if(indexPath.section == 2){
        typePassing = @"SOC";
    }
    //when a row is selected the correpsonding membership (Module, AU or Society) is then passed for further information to be collected
    LU_VC_navController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"eventsNav"];
    LU_VC_optionEvents *subController = [[detailView viewControllers] objectAtIndex:0 ];
    subController.typePassed = typePassing;
    if(indexPath.section == 0){
        NSMutableArray *current = [optionsArray objectAtIndex:0];
        subController.passedMOD = [current objectAtIndex:indexPath.row];
    }
    if(indexPath.section == 1){
        NSMutableArray *current = [optionsArray objectAtIndex:1];
        subController.passedAU = [current objectAtIndex:indexPath.row];
    }
    if(indexPath.section == 2){
        NSMutableArray *current = [optionsArray objectAtIndex:2];
        subController.passedSOC = [current objectAtIndex:indexPath.row];
    }
    //initialting and programatically setting the view is the chosen method here as it allows for resize of the form sheet. This is required due to the edit au/society event requiring more room than a form sheet offers
    [detailView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [detailView setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentModalViewController:detailView animated:YES];
    float heightOfFrame = 800.0f;
    float widthOfFrame= 600.0f;
    detailView.view.superview.frame = CGRectMake(0, 0, widthOfFrame, heightOfFrame);
    detailView.view.superview.center = self.view.center;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
