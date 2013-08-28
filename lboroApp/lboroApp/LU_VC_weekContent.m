//
//  LU_VC_weekContent.m
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_weekContent.h"

@interface LU_VC_weekContent ()

@end

@implementation LU_VC_weekContent
@synthesize startDate;
@synthesize weekData;
@synthesize theArray;
@synthesize currentContext, theTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    weekData = [theArray objectAtIndex:0];
    startDate = [theArray objectAtIndex:1];
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"'Week Commencing:' EEE d MMMM yyyy"];
    NSString *date = [myDateFormatter stringFromDate:startDate];
    self.dateLabel.text = date;
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [weekData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
     static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
     if(cell == nil)
     {
     cell = [[UITableViewCell alloc]
     initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
     }
     
     Event *current = [weekData objectAtIndex:indexPath.row];
    
    NSString *info = [NSString new];
    if ([current.type isEqual: @"MOD"]){
        UIImage *image = [UIImage imageNamed:@"LU_pic_module.png"];
        cell.imageView.image = image;
        NSArray *infoArray = [current.info componentsSeparatedByString:@"***"];
        info = infoArray[0];
    }
    if ([current.type isEqual: @"AU"]){UIImage *image = [UIImage imageNamed:@"LU_pic_au.png"];
        cell.imageView.image = image;
        info = current.info;
    }
    
    if ([current.type isEqual: @"SOC"]){UIImage *image = [UIImage imageNamed:@"LU_pic_society.png"];
        cell.imageView.image = image;
        info = current.info;}
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"EEEE"];
    NSString *starttime = [timeFormatter stringFromDate:current.starttime];
    NSString *endtime = [timeFormatter stringFromDate:current.endtime];
    
    if([current.type isEqual:@"HOL"]){
        NSString *detail = [NSString stringWithFormat:@"%@",current.name];
        cell.textLabel.text = detail;
        NSDateFormatter *timeFormatter2 = [NSDateFormatter new];
        [timeFormatter2 setDateFormat:@"EEEE dd MMMM"];
        starttime = [timeFormatter2 stringFromDate:current.starttime];
        endtime = [timeFormatter2 stringFromDate:current.endtime];
        NSString *detail3 = [NSString stringWithFormat:@"%@ - %@",starttime,endtime];
        cell.detailTextLabel.text = detail3;
    }
    else if([current.type isEqual:@"MOD"]){
        NSString *building = @"";
        if(current.building.length > 1){building = [NSString stringWithFormat:@", %@", current.building];}
        NSString *theday = [dayFormatter stringFromDate:current.starttime];
        
        NSString *detail = [NSString stringWithFormat:@"%@ %@-%@ %@%@",theday,starttime,endtime, current.room, building];
        cell.detailTextLabel.text = detail;
            
            NSArray *infoDetails = [current.info componentsSeparatedByString:@"***"];
            NSMutableString *infoString = [NSMutableString new];
            [infoString appendString:infoDetails[0]];
            if(![infoDetails[1] isEqualToString:@""])
                [infoString appendFormat:@": %@",infoDetails[1]];
 
        
        NSString *detail2 = [NSString stringWithFormat:@"%@ - %@",current.name, infoString];
        cell.textLabel.text = detail2;
    }
    else{
        NSString *starttime = [NSString new];
        NSString *endtime = [NSString new];
        if ([current.week isEqualToString:@"1"]) {
            NSDateFormatter *timeFormatter2 = [NSDateFormatter new];
            [timeFormatter2 setDateFormat:@"EEEE dd MMMM HH:mm"];
            starttime = [timeFormatter2 stringFromDate:current.starttime];
            endtime = [timeFormatter2 stringFromDate:current.endtime];
            NSString *building = @"";
            if(current.building.length > 1){building = [NSString stringWithFormat:@", %@", current.building];}
            NSString *detail = [NSString stringWithFormat:@"%@ - %@",starttime,endtime];
            NSString *detail3 = [NSString stringWithFormat:@"%@. %@%@",detail, current.room, building];
            NSString *detail2 = [NSString stringWithFormat:@"%@ - %@",current.name,current.info];
            cell.textLabel.text = detail2;
            cell.detailTextLabel.text = detail3;
        }
        else{
            starttime = [timeFormatter stringFromDate:current.starttime];
            endtime = [timeFormatter stringFromDate:current.endtime];
            NSString *building = @"";
            if(current.building.length > 1){building = [NSString stringWithFormat:@", %@", current.building];}
            NSString *theday = [dayFormatter stringFromDate:current.starttime];
            
            NSString *detail = [NSString stringWithFormat:@"%@ %@-%@ %@%@",theday,starttime,endtime, current.room, building];
            cell.detailTextLabel.text = detail;
            
            NSString *detail2 = [NSString stringWithFormat:@"%@ - %@",current.name,current.info];
            cell.textLabel.text = detail2;
        }
        
    }
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(void)refreshTable{
    NSDate *endDate = [startDate dateByAddingTimeInterval:60*60*24*7-1];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    currentContext = managedObjectContext;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(((%@<=starttime)AND(starttime<=%@)) OR ((starttime<=%@)AND(%@<=endtime))) AND (chosen LIKE '1')", startDate, endDate,startDate,startDate];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
    [request1 setEntity:entity1];
    [request1 setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"starttime" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request1 setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
        // Handle the error.
    }
    weekData= mutableFetchResults1;
    [theTableView reloadData];
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"refreshCalTable" object:nil];
    Event *current = [weekData objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([current.type isEqualToString:@"MOD"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        LU_VC_editModuleEvent *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"editModule"];
        viewcontroller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        viewcontroller.modalPresentationStyle = UIModalPresentationFormSheet;
        viewcontroller.passedEvent = current;
        viewcontroller.currentContext = currentContext;
        viewcontroller.fromCal = YES;
        [viewcontroller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [viewcontroller setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentModalViewController:viewcontroller animated:YES];
        float heightOfFrame = 800.0f;
        float widthOfFrame= 600.0f;
        viewcontroller.view.superview.frame = CGRectMake(0, 0, widthOfFrame, heightOfFrame);
        viewcontroller.view.superview.center = self.view.center;
    }
    //this method completes the same process but for AU and society events
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        LU_VC_editClubEvent *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"editClub"];
        viewcontroller.type = current.type;
        viewcontroller.passedEvent = current;
        viewcontroller.currentContext = currentContext;
        viewcontroller.fromCal = YES;
        [viewcontroller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [viewcontroller setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentModalViewController:viewcontroller animated:YES];
        float heightOfFrame = 800.0f;
        float widthOfFrame= 600.0f;
        viewcontroller.view.superview.frame = CGRectMake(0, 0, widthOfFrame, heightOfFrame);
        viewcontroller.view.superview.center = self.view.center;
    }
}

*/

- (void)viewDidUnload {
    [self setDateLabel:nil];
    [self setTheTableView:nil];
    [super viewDidUnload];
}

@end
