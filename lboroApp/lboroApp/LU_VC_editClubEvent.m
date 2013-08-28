//
//  LU_VC_editClubEvent.m
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_editClubEvent.h"

@interface LU_VC_editClubEvent ()

@end

@implementation LU_VC_editClubEvent
//outlets
@synthesize buildingPicker, startTimePicker, endTimePicker, eventInfo;
//properties
@synthesize buildings, rooms;
//passed properties
@synthesize currentContext, passedEvent, type, addNew, addeventid, fromCal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if(addNew){
        //if its a new event then a new instance of event is created and set to passedEvent
        self.navigationItem.title = @"Add New Event";
        self.navigationItem.rightBarButtonItem.title = @"Add";
        Event *newEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event"inManagedObjectContext:currentContext];
        passedEvent = newEvent;
        passedEvent.type = type;
        passedEvent.starttime = [startTimePicker date];
        passedEvent.endtime = [endTimePicker date];
        passedEvent.info = @"";
        passedEvent.eventid = addeventid;
    }
    else if(fromCal){
        eventInfo.text = [NSString stringWithFormat:@"%@",passedEvent.info];
        [startTimePicker setDate:passedEvent.starttime];
        [endTimePicker setDate:passedEvent.endtime];
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 600, 44)];
        UIBarButtonItem *discard = [[UIBarButtonItem alloc] initWithTitle:@"Discard Changes" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
        UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePressed:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSArray *buttons = [NSArray arrayWithObjects:discard, space, save, nil];
        [toolBar setItems:buttons];
        [self.view addSubview:toolBar];
        
    }
    else{
        //if its an edit then the info string and times are set
        self.navigationItem.title = passedEvent.name;
        self.navigationItem.rightBarButtonItem.title = @"Save Changes";
        eventInfo.text = [NSString stringWithFormat:@"%@",passedEvent.info];
        [startTimePicker setDate:passedEvent.starttime];
        [endTimePicker setDate:passedEvent.endtime];
    }
    //the start time is set to the end times minimum
    [startTimePicker setMinimumDate:[NSDate date]];
    [endTimePicker setMinimumDate:[startTimePicker date]];
    [self makeRoomPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setStartTimePicker:nil];
    [self setEndTimePicker:nil];
    [self setEventInfo:nil];
    [super viewDidUnload];
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

//initialise picker
//return number of components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 2;
}

//return number of rows
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [buildings count];
    }
    return [rooms count];
}

//return the title of each row
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        Building *current = [buildings objectAtIndex:row];
        return  current.name;
    }
    Room *current = [rooms objectAtIndex:row];
    return  current.name;
}

//handle the event of a row being selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //when a new building is selected the rooms are updated
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

//whhen the start time is changed it is set to the starttime property and the minimum end date is changed
- (IBAction)startTimeChanged:(id)sender {
    passedEvent.starttime = [startTimePicker date];
    [endTimePicker setMinimumDate:[startTimePicker date]];
    passedEvent.endtime = [endTimePicker date];
}

//when the end time is changed it is set to the end time property
- (IBAction)endTimeChanged:(id)sender {
    passedEvent.endtime = [endTimePicker date];
}

//when save is pressed the event is sent to a shared method which updates the database and the core event data is refreshed
- (IBAction)savePressed:(id)sender {
    
    BOOL check1 = [eventInfo.text isEqualToString:@""];
    BOOL check2 = (([startTimePicker.date compare:[NSDate date]]) == NSOrderedAscending);
    BOOL check3 = (([endTimePicker.date compare:startTimePicker.date]) == NSOrderedAscending);
    
    if(check1){
        NSString *alertStr=@"Please enter an event description";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:alertStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if(check2){
        NSString *alertStr=@"Invalid Start Date";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:alertStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if(check3){
        NSString *alertStr=@"Invalid End Date";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:alertStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else{
        passedEvent.info = eventInfo.text;
        if(addNew){
            [[sharedMethods alloc] updateEvent:passedEvent isNewEvent:YES];
        }
        else{
            [[sharedMethods alloc] updateEvent:passedEvent isNewEvent:NO];
        }
        [[sharedMethods alloc] getEventData];
        if(fromCal){
            [self dismissModalViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCalTable" object:self];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshEventTable" object:self];
        }
    }
}

//when cancel is pressed the edits are discarded and the view dismissed
- (IBAction)cancelPressed:(id)sender {
    [currentContext refreshObject:passedEvent mergeChanges:NO];
    if(fromCal){
        [self dismissModalViewControllerAnimated:YES];
    }
    else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

//keyboard dismissal
- (BOOL)disablesAutomaticKeyboardDismissal {return NO;}
- (IBAction)textReturn:(id)sender {[sender resignFirstResponder];}
- (IBAction)backgroundTouch:(id)sender {[self.parentViewController.view endEditing:YES];}
@end
