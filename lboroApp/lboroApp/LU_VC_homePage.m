//
//  LU_VC_homePage.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_homePage.h"

@interface LU_VC_homePage ()

@end

@implementation LU_VC_homePage

@synthesize popover;
@synthesize dayViewData;
@synthesize newsTableData;
@synthesize dayViewTable;
@synthesize newsTable;
@synthesize popup;
@synthesize welcomeLabel;
@synthesize loadingView;
@synthesize helpImage;
@synthesize helpImage2;

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
    popup = NO;
    [[sharedMethods alloc]getEventData];
    [self getEvents];
    [self getNews];
    [self makeWelcomeLabel];
    
    // Do any additional setup after loading the view.
}

-(void)makeWelcomeLabel{
    
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_welcomeLabel.php"];
    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    NSArray *variables = [NSArray arrayWithObjects: userid, nil];
    NSMutableArray *results = [[sharedMethods alloc] connectPHPurl:url variables:variables];
    NSString *welcome = [NSString new];
    if([results[2] isEqualToString:@"0"]){
        welcome = [NSString stringWithFormat:@"Welcome %@. Today's date is %@. Hope you are enjoying your %@ break!", results[0],results[1],results[3]];
    }
    else{
            welcome = [NSString stringWithFormat:@"Welcome %@. Today's date is %@. Its currently Week %@ of Semester %@.", results[0],results[1],results[3],results[2]];
    }
    welcomeLabel.text = welcome;
}

-(void)refreshDayInfo{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshDayInfo" object:nil];
    [self getEvents];
    [dayViewTable reloadData];
    
}


-(void)getNews{

    [[sharedMethods alloc] getNewsData];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Newsstory" inManagedObjectContext:managedObjectContext];
    [request1 setEntity:entity1];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request1 setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
        // Handle the error.
    }
    
    newsTableData = [NSMutableArray new];
    [newsTableData addObjectsFromArray:mutableFetchResults1];
    
}



-(void)getEvents{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *startDay = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today];
    [startDay setHour:00];
    [startDay setMinute:00];
    [startDay setSecond:00];
    NSDateComponents *endDay = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today];
    [endDay setHour:23];
    [endDay setMinute:59];
    [endDay setSecond:59];
    NSDate *startDate = [calendar dateFromComponents:startDay];
    NSDate *endDate = [calendar dateFromComponents:endDay];
    
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
    
    dayViewData = [NSMutableArray new];
    [dayViewData addObjectsFromArray:mutableFetchResults1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)learnPressed:(id)sender {
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults stringForKey:@"userid"];
    
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_learn.php"];
    NSMutableURLRequest *req = [
                                NSMutableURLRequest requestWithURL:url
                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                timeoutInterval:60
                                ];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString *postData = [NSString stringWithFormat:@"xmlData=<document><elem0>%@</elem0></document>&",userid];
    NSString *length = [NSString stringWithFormat:@"%d", [postData length]];
    
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
    LU_VC_webView *myViewController = [[LU_VC_webView alloc] init];
    myViewController.request = req;
    myViewController.needToolbar = YES;
    [self.navigationController pushViewController:myViewController animated:YES];
    
}

- (IBAction)mapPressed:(id)sender {
    LU_VC_webView *myViewController = [[LU_VC_webView alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"campus-map" ofType:@"pdf"];
    NSURL *pdfURL = [NSURL fileURLWithPath:path];
    myViewController.pdfURL = pdfURL;
    myViewController.needToolbar = NO;
    [self.navigationController pushViewController:myViewController animated:YES];
    
}

-(void) dismissObservers{
    
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popOverLOGOUT" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popOverFAQ" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popOverREFRESH" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popOverMEMBER" object:nil];
}

-(void)logOutPressed
{
    [self dismissObservers];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"no" forKey:@"loggedin"];
    [defaults synchronize];
    [popover dismissPopoverAnimated:NO];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)memberPressed
{
    [self dismissObservers];
    [popover dismissPopoverAnimated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDayInfo) name:@"refreshDayInfo" object:nil];
    [self performSegueWithIdentifier:@"memberSegue" sender:self];
}

-(void)refreshPressed
{
    [self dismissObservers];
    [popover dismissPopoverAnimated:NO];
    [[sharedMethods alloc] getEventData];
    [self refreshDayInfo];
}

-(void)faqPressed
{
    [self dismissObservers];
    [popover dismissPopoverAnimated:NO];
    [self performSegueWithIdentifier:@"faqSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"popoverSegue"])
    {
        popover = [(UIStoryboardPopoverSegue *)segue popoverController];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutPressed) name:@"popOverLOGOUT" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(faqPressed) name:@"popOverFAQ" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPressed) name:@"popOverREFRESH" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberPressed) name:@"popOverMEMBER" object:nil];
    }

}


- (void)viewDidUnload {
    [self setDayViewTable:nil];
    [self setWelcomeLabel:nil];
    [self setHelpImage:nil];
    [self setHelpImage2:nil];
    [super viewDidUnload];
}






#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == dayViewTable){return [dayViewData count]+1;}
    else if(tableView == newsTable){return [newsTableData count];}
    else return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == dayViewTable){
        
        NSInteger row = [indexPath row];
        NSInteger total2 = [dayViewData count];
        
        if(row<total2){
            
            
            static NSString *CellIdentifier = @"dayViewCell";
            LU_cell_dayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[LU_cell_dayViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            Event *current = [dayViewData objectAtIndex:indexPath.row];
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
            
            NSDateFormatter *timeFormatter = [NSDateFormatter new];
            [timeFormatter setDateFormat:@"HH:mm"];
            
            if([current.type isEqual:@"HOL"]){
                NSDateFormatter *timeFormatter2 = [NSDateFormatter new];
                [timeFormatter2 setDateFormat:@"EEE dd MMM"];
                NSString *starttime = [timeFormatter2 stringFromDate:current.starttime];
                NSString *endtime = [timeFormatter2 stringFromDate:current.endtime];
                NSString *detail3 = [NSString stringWithFormat:@"%@ - %@",starttime,endtime];
                cell.time.text = detail3;
                cell.location.text = @"";
                NSString *detail = [NSString stringWithFormat:@"%@",current.name];
                cell.title.text = detail;
            }
            else if([current.type isEqual:@"MOD"]){
                NSString *starttime = [timeFormatter stringFromDate:current.starttime];
                NSString *endtime = [timeFormatter stringFromDate:current.endtime];
                NSString *building = @"";
                if(current.building.length > 1){building = [NSString stringWithFormat:@", %@", current.building];}
                NSString *detail = [NSString stringWithFormat:@"%@-%@",starttime,endtime];
                cell.time.text = detail;
                NSString *detail3 = [NSString stringWithFormat:@"%@%@",current.room, building];
                
                NSArray *infoDetails = [current.info componentsSeparatedByString:@"***"];
                NSMutableString *infoString = [NSMutableString new];
                [infoString appendString:infoDetails[0]];
                if(![infoDetails[1] isEqualToString:@""])
                    [infoString appendFormat:@": %@",infoDetails[1]];
                
                NSString *detail2 = [NSString stringWithFormat:@"%@ - %@",current.name,infoString];
                cell.title.text = detail2;
                cell.time.text = detail;
                cell.location.text = detail3;
                
            }
            else{
                NSString *starttime = [NSString new];
                NSString *endtime = [NSString new];
                if ([current.week isEqualToString:@"1"]) {
                    NSDateFormatter *timeFormatter2 = [NSDateFormatter new];
                    [timeFormatter2 setDateFormat:@"EEE dd MMM HH:mm"];
                    starttime = [timeFormatter2 stringFromDate:current.starttime];
                    endtime = [timeFormatter2 stringFromDate:current.endtime];
                }
                else{
                    starttime = [timeFormatter stringFromDate:current.starttime];
                    endtime = [timeFormatter stringFromDate:current.endtime];
                }
            
                NSString *building = @"";
                if(current.building.length > 1){building = [NSString stringWithFormat:@", %@", current.building];}
                NSString *detail = [NSString stringWithFormat:@"%@ - %@",starttime,endtime];
                NSString *detail3 = [NSString stringWithFormat:@"%@%@",current.room, building];
                NSString *detail2 = [NSString stringWithFormat:@"%@ - %@",current.name,current.info];
                cell.title.text = detail2;
                cell.time.text = detail;
                cell.location.text = detail3;
            
            }
            return cell;
        }
        else{
            static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
            }
            cell.textLabel.text = @"Click here to view your full diary";
            return cell;
        }
    }
    
    else if(tableView == newsTable){
        
        static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
        }
        Newsstory *current = [newsTableData objectAtIndex:indexPath.row];
        NSString *detail2 = current.title;
        cell.textLabel.text = detail2;

        return cell;
    }
    else
        return nil;
}

#pragma mark -
#pragma mark Table Delegate Methods

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == newsTable){return indexPath;}
    else if(tableView == dayViewTable){
        NSInteger row = [indexPath row];
        if(row == dayViewData.count){
            return indexPath;
        }
        else{
            return nil;
        }
    }
    else{return nil;}
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == newsTable){
        Newsstory *current = [newsTableData objectAtIndex:indexPath.row];
        LU_VC_webView *myViewController =   [[LU_VC_webView alloc] init];
        NSString *detailMessage = current.link;
        myViewController.websiteURL = detailMessage;
        myViewController.title = current.title;
        myViewController.needToolbar = YES;
        [newsTable deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:myViewController animated:YES];
        
    }
    
    if(tableView == dayViewTable){
        [dayViewTable deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:@"diaryViewSegue" sender:self];
    }
     
    
}

- (void)loginAnimationDone{
    [loadingView removeFromSuperview];
}

- (IBAction)cashCred:(id)sender {
    
    LU_VC_webView *myViewController =   [[LU_VC_webView alloc] init];
    NSString *detailMessage = @"https://cash-plus.lboro.ac.uk/session/login";
    myViewController.websiteURL = detailMessage;
    myViewController.title = @"Add Cash Plus";
    myViewController.needToolbar = YES;
    
    [self.navigationController pushViewController:myViewController animated:YES];
}
- (IBAction)printCred:(id)sender {
    
    LU_VC_secureWebView *myViewController =   [[LU_VC_secureWebView alloc] init];
    myViewController.title = @"Add Printer Credits";
    
    [self.navigationController pushViewController:myViewController animated:YES];
}
- (IBAction)helpButton:(id)sender {
    if (helpImage.hidden == YES) {
        [helpImage setHidden:NO];
    }
    else{
        [helpImage setHidden:YES];
    }
    
}

- (IBAction)settingsPopover:(id)sender {
    if(popup){
        
        [popover dismissPopoverAnimated:YES];
        popup = NO;
    }
    else{

        [self performSegueWithIdentifier:@"popoverSegue" sender:self];
        popup = YES;
    }
}

- (IBAction)helpButton2:(id)sender {
    if (helpImage2.hidden == YES) {
        [helpImage2 setHidden:NO];
    }
    else{
        [helpImage2 setHidden:YES];
    }
}
@end
