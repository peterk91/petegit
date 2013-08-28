//
//  LU_VC_editModuleEvent.m
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_editModuleEvent.h"

@interface LU_VC_editModuleEvent ()

@end

@implementation LU_VC_editModuleEvent
//outlets
@synthesize endTime, startTime, day, eventInfo, startPeriod, length, buildingPicker, eventType, semester;
//properties
@synthesize buildings, rooms, eventTypes, days;
//passed properties
@synthesize passedEvent, addNew, currentContext, addeventid, fromCal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //if the addNew property is true it means a new event is being added otherwise an event is being edited. the titles and buttons are configured accordingly
    if(addNew){
        self.navigationItem.title = @"Add New Event";
        self.navigationItem.rightBarButtonItem.title = @"Add";
        //if its a new event and new event object is created
        Event *newEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event"inManagedObjectContext:currentContext];
        passedEvent = newEvent;
        //the eventid is set to the module database id as the event id does not yet exist in the online database. therefore this can be taken advantage of and the information can be passed using this property
        passedEvent.eventid = addeventid;
        passedEvent.type = @"MOD";
    }
    else if(fromCal){
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 600, 44)];
        UIBarButtonItem *discard = [[UIBarButtonItem alloc] initWithTitle:@"Discard Changes" style:UIBarButtonItemStyleBordered target:self action:@selector(discardPressed:)];
        UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePressed:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSArray *buttons = [NSArray arrayWithObjects:discard, space, save, nil];
        [toolBar setItems:buttons];
        [self.view addSubview:toolBar];
    }
    else{
        self.navigationItem.title = passedEvent.name;
        self.navigationItem.rightBarButtonItem.title = @"Save Changes";
    }
    //the components are then initiated
    [self makeDayPicker];
    [self makeRoomPicker];
    [self makeInfo];
    [self makeStartPeriod];
    [self makeLength];
    [self makeSemester];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setBuildingPicker:nil];
    [self setLength:nil];
    [self setDay:nil];
    [self setEventInfo:nil];
    [self setStartPeriod:nil];
    [self setLength:nil];
    [self setSemester:nil];
    [super viewDidUnload];
}

//****************RETRIEVING DATA FOR FORM COMPONENTS****************

-(void)makeSemester{
    //if a module event is being edited then the semester of the event is retrieved and the correct segment is selected
    //as the periodID is not needed after the semester is retrieved the property is used to store the selected semester number
    if(!addNew){
        //the semester is retrieved using the period id of the event
        NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"YearPeriods" inManagedObjectContext:currentContext];
        [request1 setEntity:entity1];
        NSString *predicateString = [NSString stringWithFormat:@"(periodID LIKE '%@')",passedEvent.periodID];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [request1 setPredicate:predicate];
        NSError *error = nil;
        NSMutableArray *mutableFetchResults1 = [[currentContext executeFetchRequest:request1 error:&error] mutableCopy];
        if (mutableFetchResults1 == nil) {
        }
        YearPeriods *current = [mutableFetchResults1 objectAtIndex:0];
        NSInteger currentYearPeriod = [current.semester integerValue]-1;
        passedEvent.periodID = current.semester;
        semester.selectedSegmentIndex = currentYearPeriod;
    }
    else{
        //the new events period id is set to the default selected incase there is no change in selection
        passedEvent.periodID = @"1";
    }
}

-(void)makeDayPicker{
    //the days array is created.
    days = [NSArray arrayWithObjects:@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil];
    //for an edit the correct day is highlighted otherwise the default is set to the day
    if(!addNew){
        NSInteger curDay = [passedEvent.day integerValue]-1;
        [day selectRow:curDay inComponent:0 animated:YES];
    }
    else{
        passedEvent.day = @"1";
    }
}

-(void)makeStartPeriod{
    //the start period is selected for an edit.
    if(!addNew){
        NSInteger startPeriodPassed = [passedEvent.startPeriod integerValue]-1;
        startPeriod.selectedSegmentIndex = startPeriodPassed;
    }
    else{
        passedEvent.startPeriod = @"1";
    }
}

-(void)makeLength{
    //the length is selected for an edit.
    if(!addNew){
        NSInteger lengthPassed = [passedEvent.periodLength integerValue]-1;
        length.selectedSegmentIndex = lengthPassed;
    }
    else{
        passedEvent.periodLength = @"1";
    }
    NSInteger amount = 8-[startPeriod selectedSegmentIndex];
    for(int x = 0; x<5; x++){
        if(x<=amount){
            [length setEnabled:YES forSegmentAtIndex:x];}
        else{
            [length setEnabled:NO forSegmentAtIndex:x];
        }
    }
}

-(void)makeInfo{
    //the info string is broken down into the event type and the event extra info. for an edit the corresponding fields are then populated with this information.
    eventTypes = [NSArray arrayWithObjects:@"Lecture",@"Tutorial",@"Practical",@"Other", nil];
    if(!addNew){
        NSArray *infoArray = [passedEvent.info componentsSeparatedByString:@"***"];
        NSInteger infocount = 0;
        NSInteger infosegment = -1;
        for (NSString* info in eventTypes){
            if ([info rangeOfString:[infoArray objectAtIndex:0]].location != NSNotFound){
                infosegment = infocount;
            }
            infocount++;
        }
        eventType.selectedSegmentIndex=infosegment;
        eventInfo.text = [infoArray objectAtIndex:1];
    }
    else{
        passedEvent.info = @"Lecture***";
    }
}

-(void)makeRoomPicker{
    //all the buildings and rooms are retrieved and put into two arrays
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Building" inManagedObjectContext:currentContext];
    [request1 setEntity:entity1];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request1 setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults1 = [[currentContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
    }
    buildings = [NSMutableArray new];
    [buildings addObjectsFromArray:mutableFetchResults1];
    NSInteger buildrow = -1;
    //if its an edit the selected building is found and selected
    if(!addNew){
        NSString *eventBuilding = passedEvent.building;
        NSInteger buildcount = 0;
        for (Building* build in buildings){
            if ([build.name rangeOfString:eventBuilding].location != NSNotFound){
                buildrow = buildcount;
            }
            buildcount++;
        }
        [buildingPicker selectRow:buildrow inComponent:0 animated:NO];
    }
    else
        [buildingPicker selectRow:0 inComponent:0 animated:NO];
    [self getfilteredRooms];
    //the filtered rooms (the rooms for the selected building) are then found and displayed. the selected room is then chosen
    NSInteger roomrow = -1;
    if(!addNew){
        NSString *eventRoom = passedEvent.room;
        NSInteger roomcount = 0;
        for (Room* aroom in rooms){
            if ([aroom.name rangeOfString:eventRoom].location != NSNotFound){
                roomrow = roomcount;
            }
            roomcount++;
        }
    }
    [buildingPicker reloadAllComponents];
    //if new then the first building and room are selected
    if(addNew){
        NSInteger buildrow = [buildingPicker selectedRowInComponent:0];
        Room *curbuild = [rooms objectAtIndex:buildrow];
        NSInteger roomrow = [buildingPicker selectedRowInComponent:1];
        Room *curroom = [rooms objectAtIndex:roomrow];
        passedEvent.building = curbuild.name;
        passedEvent.room = curroom.name;
    }
    else{
        [buildingPicker selectRow:buildrow inComponent:0 animated:NO];
        [buildingPicker selectRow:roomrow inComponent:1 animated:NO];
    }
}

-(void)getfilteredRooms{
    //this function sets the room array to the rooms in the selected building
    NSInteger row = [buildingPicker selectedRowInComponent:0];
    Building *selected = [buildings objectAtIndex:row];
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:currentContext];
    [request2 setEntity:entity2];
    NSString *predicateString = [NSString stringWithFormat:@"(buildingid LIKE '%@')",selected.buildingid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    [request2 setPredicate:predicate];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors2 = [[NSArray alloc] initWithObjects:sortDescriptor2, nil];
    [request2 setSortDescriptors:sortDescriptors2];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults2 = [[currentContext executeFetchRequest:request2 error:&error] mutableCopy];
    if (mutableFetchResults2 == nil) {
        // Handle the error.
    }
    rooms = [NSMutableArray new];
    [rooms addObjectsFromArray:mutableFetchResults2];
}

//****************BUTTON PRESSES****************
//this fires when save is pressed
- (IBAction)savePressed:(id)sender {
    //a shared method updates the oneline database
    if(addNew){
        [[sharedMethods alloc] updateMODEvent:passedEvent isNewEvent:YES];
    }
    else{
        [[sharedMethods alloc] updateMODEvent:passedEvent isNewEvent:NO];
    }
    //the core data is refreshed to reflect the new /edited entires and the view is dismissed
    [[sharedMethods alloc] getEventData];
    if(fromCal){
        [self dismissModalViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCalTable" object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshDayTable" object:self];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshEventTable" object:self];
    }
}
//the edit / new information is discarded and the view is dismissed
- (IBAction)discardPressed:(id)sender {
    [currentContext refreshObject:passedEvent mergeChanges:NO];
    if(fromCal){
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//****************CHANGES MADE TO FORM DEALT WITH HERE****************

//handles what happends when a new room / building / day is selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(thePickerView == buildingPicker){
        if(component ==0) {
            Building *cur = [buildings objectAtIndex:row];
            passedEvent.building = cur.name;
            [self getfilteredRooms];
            [buildingPicker reloadComponent:1];
            NSInteger curroomrow = [buildingPicker selectedRowInComponent:1];
            Room *curroom = [rooms objectAtIndex:curroomrow];
            passedEvent.room = curroom.name;
        }
        else{
            Room *curroom = [rooms objectAtIndex:row];
            passedEvent.room = curroom.name;
        }
    }
    else{
        passedEvent.day = [NSString stringWithFormat:@"%d",(row+1)];
    }
    
}

//when the event type is changed the info string is updated
- (IBAction)eventTypeChanged:(id)sender {
    NSMutableString *infoString = [NSMutableString new];
    NSInteger selEventType = [eventType selectedSegmentIndex];
    [infoString appendString:[eventTypes objectAtIndex:selEventType]];
    [infoString appendString:@"***"];
    [infoString appendString:eventInfo.text];
    passedEvent.info = infoString;
}

//when the extra info is changed the info string is updated
- (IBAction)infoChanged:(id)sender {
    NSMutableString *infoString = [NSMutableString new];
    NSInteger selEventType = [eventType selectedSegmentIndex];
    [infoString appendString:[eventTypes objectAtIndex:selEventType]];
    [infoString appendString:@"***"];
    [infoString appendString:eventInfo.text];
    passedEvent.info = infoString;
}

//when the semester is changed the periodID is updated
- (IBAction)eventPeriodChanged:(id)sender {
    NSInteger selSem = [semester selectedSegmentIndex]+1;
    NSString *selSemStr = [NSString stringWithFormat:@"%d",selSem];
    passedEvent.periodID = selSemStr;
}

//when the event start is changed the startPeriod is updated
- (IBAction)eventStartChanged:(id)sender {
    NSInteger amount = 8-[startPeriod selectedSegmentIndex];
    
    for(int x = 0; x<5; x++){
        if(x<=amount){
            [length setEnabled:YES forSegmentAtIndex:x];}
        else{
            [length setEnabled:NO forSegmentAtIndex:x];
            if([length selectedSegmentIndex]==-1){
                length.selectedSegmentIndex = amount;
            }
        }
    }
    
    //add one due to index
    passedEvent.startPeriod = [NSString stringWithFormat:@"%d",([startPeriod selectedSegmentIndex]+1)];
}

//when the event length is changed the periodLength is updated
- (IBAction)eventLengthChanged:(id)sender {
    passedEvent.periodLength = [NSString stringWithFormat:@"%d",([length selectedSegmentIndex]+1)];
}

//setting up the picker
//returns the number of components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    if(thePickerView == buildingPicker)
        return 2;
    else
        return 1;
}
//returns the number of rows in each component
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if(thePickerView == buildingPicker){
        if (component == 0) {
            return [buildings count];
        }
        else
            return [rooms count];
    }
    else
        return [days count];
}

//returns the title for each row
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(thePickerView == buildingPicker){
        if (component == 0) {
            Building *current = [buildings objectAtIndex:row];
            return  current.name;
        }
        else{
            Room *current = [rooms objectAtIndex:row];
            return  current.name;
        }
    }
    else
        return [days objectAtIndex:row];
}

//keyboard dismissal
- (BOOL)disablesAutomaticKeyboardDismissal {return NO;}
- (IBAction)textReturn:(id)sender {[sender resignFirstResponder];}
- (IBAction)backgroundTouch:(id)sender {[self.parentViewController.view endEditing:YES];}
@end
