//
//  LU_VC_weekViewController.m
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_weekViewController.h"

@interface LU_VC_weekViewController ()

@end

@implementation LU_VC_weekViewController

@synthesize pageViewController;
@synthesize dateArray;
@synthesize wholeArray;
@synthesize currentContext;

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
    [super viewDidLoad];
    
    //Instantiate the model array
    
    NSDate *today = [NSDate date];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *changeDate = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today];
    [changeDate setHour:01];
    [changeDate setMinute:00];
    [changeDate setSecond:00];
    NSDate *startDate = [gregorian dateFromComponents:changeDate];
    
    
    NSDateComponents *dateComponent =
    [gregorian components:(NSWeekdayCalendarUnit) fromDate:startDate];
    
    NSInteger weekday = [dateComponent weekday];
    NSInteger dateDifference;
    
    if(weekday == 1){dateDifference = -6;}
    if(weekday == 2){dateDifference = 0;}
    if(weekday == 3){dateDifference = -1;}
    if(weekday == 4){dateDifference = -2;}
    if(weekday == 5){dateDifference = -3;}
    if(weekday == 6){dateDifference = -4;}
    if(weekday == 7){dateDifference = -5;}
    
    [[sharedMethods alloc] getEventData];
    
    NSDate *startDate1 = [startDate dateByAddingTimeInterval:60*60*24*dateDifference];
    dateArray = [[NSMutableArray alloc] init];
    for (int index = -20; index <= 20 ; index++)
    {
        NSDate *newDate = [startDate1 dateByAddingTimeInterval:60*60*24*index*(7)];
        [dateArray addObject:newDate];
    }
    
    wholeArray = [NSMutableArray new];
    
    for (NSDate *startDate in dateArray) {

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
        
        NSMutableArray *weekData = [NSMutableArray new];
        [weekData addObjectsFromArray:mutableFetchResults1];
        
        NSMutableArray *currentArray = [NSMutableArray new];
        [currentArray addObject:weekData];
        [currentArray addObject:startDate];
        [wholeArray addObject:currentArray];
    }
    
    pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    
    LU_VC_weekContent *contentViewController = [[LU_VC_weekContent alloc] initWithNibName:@"LU_VC_weekContent" bundle:nil];
    contentViewController.theArray = [self.wholeArray objectAtIndex:20];
    contentViewController.currentContext = currentContext;
    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    [self addChildViewController:pageViewController];
    
    [self.view addSubview:pageViewController.view];
    
    [pageViewController didMoveToParentViewController:self];
    
    CGRect pageViewRect = self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, 90.0, 62.0);
    pageViewController.view.frame = pageViewRect;
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.wholeArray indexOfObject:[(LU_VC_weekContent *)viewController theArray]];
    if(currentIndex == 0)
    {
        return nil;
    }
    LU_VC_weekContent *contentViewController = [[LU_VC_weekContent alloc] init];
    contentViewController.theArray = [wholeArray objectAtIndex:currentIndex - 1];
    contentViewController.currentContext = currentContext;
    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.wholeArray indexOfObject:[(LU_VC_weekContent *)viewController theArray]];
    if(currentIndex == wholeArray.count-1)
    {
        return nil;
    }
    LU_VC_weekContent *contentViewController = [[LU_VC_weekContent alloc] init];
    contentViewController.theArray = [wholeArray objectAtIndex:currentIndex + 1];
    contentViewController.currentContext = currentContext;
    
    return contentViewController;
}



- (void)viewDidUnload {

    [super viewDidUnload];
}


@end
