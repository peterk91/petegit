//
//  LU_VC_optionEvents.m
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_optionEvents.h"

@interface LU_VC_optionEvents ()

@end

@implementation LU_VC_optionEvents
//outlets
@synthesize eventTableView, helpImage;
//properties
@synthesize tableData, currentContext, addNew, optionID, rowsel, semPassed;
//passed properties
@synthesize passedMOD, passedAU, passedSOC, typePassed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //optionID is the databaseID of the type of membership you are viewing the events of. For a module its the moduleID of the module etc.
    optionID = [NSString new];
    //the type of object passed is figured out by using the type passed string. the string matches the type. this allows for correct selection of the passed object to set the ID and the title
    if([typePassed isEqualToString:@"MOD"]){
        optionID =  passedMOD.databaseID;
        self.navigationItem.title = passedMOD.title;
    }
    if([typePassed isEqualToString:@"AU"]){
        optionID = passedAU.databaseID;
        self.navigationItem.title = passedAU.title;
    }
    if([typePassed isEqualToString:@"SOC"]){
        optionID = passedSOC.databaseID;
        self.navigationItem.title = passedSOC.title;
    }
    [self getEvents];
 
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    [self setEventTableView:nil];
    [self setHelpImage:nil];
    [super viewDidUnload];
}

//this method gathers the events to display on the table.
-(void)getEvents{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    currentContext = appDelegate.managedObjectContext;
    NSError *error = nil;
    NSMutableArray *mutableFetchResults2 = [NSMutableArray new];
    //sets up the sorting method which can be used in all cases
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"starttime" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    //the events can be gathered in two ways depending on the type of membership being displayed. for a module one method is used and for AU and societies another is used
    if([typePassed isEqualToString:@"MOD"]){
        //if gathering events for a module firsty it must be ensured that only one event of each type from each semester is displayed. For example in the calandar there could be an entry for every thursday for a lecture in semester 1. however the 15 weeks worth of entries do not need to be shown. this is done by fetching the periodIDs of week 1 in sememster 1 and week 1 in semester 2. these are then used to narrow down the events search. this is possible as the app does not currently allow for events to be set at different weeks.
        NSString *predicateString = [NSString new];
        predicateString = [NSString stringWithFormat:@"(week LIKE '1')"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"YearPeriods" inManagedObjectContext:currentContext];
        [request1 setEntity:entity1];
        [request1 setPredicate:predicate];
        NSMutableArray *mutableFetchResults1 = [[currentContext executeFetchRequest:request1 error:&error] mutableCopy];
        if (mutableFetchResults1 == nil) {
        }
        YearPeriods *current1 = [mutableFetchResults1 objectAtIndex:0];
        NSString *periodID1 = current1.periodID;
        YearPeriods *current2 = [mutableFetchResults1 objectAtIndex:1];
        NSString *periodID2 = current2.periodID;
        //these are the periodIDs for week 1 for semester 1 and 2
        NSString *predicateString2 = [NSString stringWithFormat:@"(databaseID LIKE '%@' AND type LIKE '%@' AND (periodID LIKE '%@' OR periodID LIKE '%@'))",optionID,typePassed,periodID1, periodID2];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:predicateString2];
        NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:currentContext];
        [request2 setEntity:entity2];
        [request2 setPredicate:predicate2];
        [request2 setSortDescriptors:sortDescriptors];
        //the search is then completed for events
        mutableFetchResults2 = [[currentContext executeFetchRequest:request2 error:&error] mutableCopy];
        if (mutableFetchResults2 == nil) {
            // Handle the error.
        }
        
    }
    else {
        //the au and society events are stored as set days. there is currently no functionality to allow for recurring events. therefore no further filters need to be applied.
        NSDate *today = [NSDate date];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"( (type LIKE %@ ) AND(( %@ <= starttime )OR(%@ <= endtime)) AND ( databaseID = %@))", typePassed, today, today, optionID];
        NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:currentContext];
        [request1 setEntity:entity1];
        [request1 setPredicate:predicate];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"starttime" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request1 setSortDescriptors:sortDescriptors];
        
        NSError *error = nil;
        
        mutableFetchResults2 = [[currentContext executeFetchRequest:request1 error:&error] mutableCopy];
        if (mutableFetchResults2 == nil) {
            // Handle the error.
        }
    }
    tableData = [NSMutableArray new];
    [tableData addObjectsFromArray:mutableFetchResults2];
}

//when done is pressed the view is dismissed
- (IBAction)donePressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)infoPressed:(id)sender {
    if (helpImage.hidden == YES) {
        [helpImage setHidden:NO];
    }
    else{
        [helpImage setHidden:YES];
    }
}

//when the used clicks the add button a segue is called. depending on the type of button pressed the relevant segue will be selected
- (IBAction)addButton:(id)sender {
    //the addNew variable is assigned and then later passed to the new view. this allows the system to disinguish between an edit and a add new request
    addNew = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"refreshEventTable" object:nil];
    if([typePassed isEqualToString:@"MOD"])
        [self performSegueWithIdentifier:@"editModuleSegue" sender:self];
    else
        [self performSegueWithIdentifier:@"editClubSegue" sender:self];
}

//when the edit button is pressed a segue is called. depending on the type of button pressed the relevant segue will be selected
- (void)editButtonPressed:(id)sender{
    //each button is tagged with the row number. this allows for the this to be set to a global variable which identifes the event selected
    UIButton *edit = (UIButton*)sender;
    rowsel = edit.tag;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"refreshEventTable" object:nil];
    if([typePassed isEqualToString:@"MOD"])
        [self performSegueWithIdentifier:@"editModuleSegue" sender:self];
    else
        [self performSegueWithIdentifier:@"editClubSegue" sender:self];
    
}

//when the view appears the getEvents method is called. this is as the table needs to refresh every time the view is seen as a navigation contorller would not call viewdidload when the view is pushed backwards
-(void)refreshTable{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshEventTable" object:nil];
    [self getEvents];
    [eventTableView reloadData];
}

//two different segues are catered for in this method
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //this segue is when a module is being added or edited
    if ([[segue identifier] isEqualToString:@"editModuleSegue"]){
        //if an event if being edited addNew will be false
        LU_VC_editModuleEvent *newController =  [segue destinationViewController];
        if(!addNew)
            //the event is passed to the new controller. the selected row is found using the rowsel variable
            newController.passedEvent = [tableData objectAtIndex:rowsel];
        else{
            //the database id of the current module is passed, so a new event can be created for this module and addNew is set to yes. after this is set add new is set to no as when coming back to this view edit could be pressed.
            newController.addeventid = passedMOD.databaseID;
            newController.addNew = YES;
            addNew = NO;
        }
        //the current context is also passed to allow for events to be saved and edited using coredata
        newController.currentContext = currentContext;
    }
    //this method completes the same process but for AU and society events
    if ([[segue identifier] isEqualToString:@"editClubSegue"])
    {
        LU_VC_editClubEvent *newController =  [segue destinationViewController];
        newController.type = typePassed;
        if(!addNew)
            newController.passedEvent = [tableData objectAtIndex:rowsel];
        else{
            if([typePassed isEqualToString:@"AU"])
                newController.addeventid = passedAU.databaseID;
            else
                newController.addeventid = passedSOC.databaseID;
            newController.addNew = YES;
            addNew = NO;
        }
        newController.currentContext = currentContext;
    }
}

//setting up the table
#pragma mark - Table view data source
//returns the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

//returs the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

//configures each cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"eventCell";
    LU_cell_eventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LU_cell_eventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Event *currentEvent = [tableData objectAtIndex:indexPath.row];
    //using information from the event strings are created for display. For module events only Thursday needs to be shown. For AU and society events the date needs to be displayed.
    if([typePassed isEqualToString:@"MOD"]){
        NSDateFormatter *timeFormatter = [NSDateFormatter new];        
        [timeFormatter setDateFormat:@"EEEE HH:mm"];
        NSDateFormatter *timeFormatter2 = [NSDateFormatter new];
        [timeFormatter2 setDateFormat:@"HH:mm"];
        NSString *starttime = [timeFormatter stringFromDate:currentEvent.starttime];
        NSString *endtime = [timeFormatter2 stringFromDate:currentEvent.endtime];
        NSString *building = @"";
        if(currentEvent.building.length > 1){building = [NSString stringWithFormat:@", %@", currentEvent.building];}
        NSString *detail = [NSString stringWithFormat:@"%@-%@",starttime,endtime];
        NSString *detail3 = [NSString stringWithFormat:@"%@%@",currentEvent.room, building];
        NSArray *infoDetails = [currentEvent.info componentsSeparatedByString:@"***"];
        NSMutableString *infoString = [NSMutableString new];
        [infoString appendString:infoDetails[0]];
        if(![infoDetails[1] isEqualToString:@""])
            [infoString appendFormat:@" - %@",infoDetails[1]];
        cell.eventTitle.text = infoString;
        cell.eventTime.text= detail;
        cell.eventPlace.text = detail3;
    }
    else{
        NSDateFormatter *timeFormatter2 = [NSDateFormatter new];
        [timeFormatter2 setDateFormat:@"dd/MM/YYYY HH:mm"];
        NSString *starttime = [timeFormatter2 stringFromDate:currentEvent.starttime];
        NSString *endtime = [timeFormatter2 stringFromDate:currentEvent.endtime];
        NSString *building = @"";
        if(currentEvent.building.length > 1){building = [NSString stringWithFormat:@", %@", currentEvent.building];}
        NSString *detail = [NSString stringWithFormat:@"%@ - %@",starttime,endtime];
        NSString *detail3 = [NSString stringWithFormat:@"%@%@",currentEvent.room, building];
        NSString *detail2 = [NSString stringWithFormat:@"%@",currentEvent.info];
        cell.eventTitle.text = detail2;
        cell.eventTime.text= detail;
        cell.eventPlace.text = detail3;
    }
    //the buttons are tagged with the cell row so they can be identifed when pressed
    [cell.editButton setTag:indexPath.row];
    [cell.editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
    //allows for a row to be checked and unchecked
    if([currentEvent.chosen isEqualToString:@"1"]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

//handles what happens when a row is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //the event is retireved
    Event *current =  [tableData objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //the chosen proprerty is set accordingly along with the checkmark on the row
    if([current.chosen isEqualToString:@"1"]){
        [current setChosen:@"0"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[sharedMethods alloc] updateUserSelection:current toDelete:YES];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [current setChosen:@"1"];
        [[sharedMethods alloc] updateUserSelection:current toDelete:NO];
    }
    //the row is deselected with animation
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
