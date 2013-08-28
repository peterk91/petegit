//
//  LU_VC_editModuleEvent.h
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "AppDelegate.h"

@interface LU_VC_editModuleEvent : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
//outlets
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UIPickerView *day;
@property (weak, nonatomic) IBOutlet UITextField *eventInfo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *startPeriod;
@property (weak, nonatomic) IBOutlet UISegmentedControl *length;
@property (weak, nonatomic) IBOutlet UIPickerView *buildingPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *eventType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *semester;
//properties
@property NSMutableArray *buildings;
@property NSMutableArray *rooms;
@property NSArray *eventTypes;
@property NSArray *days;
//passed properties
@property Event *passedEvent;
@property BOOL addNew;
@property BOOL fromCal;
@property NSManagedObjectContext *currentContext;
@property NSString *addeventid;
//actions
- (IBAction)eventPeriodChanged:(id)sender;
- (IBAction)eventStartChanged:(id)sender;
- (IBAction)eventLengthChanged:(id)sender;
- (IBAction)savePressed:(id)sender;
- (IBAction)eventTypeChanged:(id)sender;
- (IBAction)discardPressed:(id)sender;
- (IBAction)infoChanged:(id)sender;
//Keyboard Dismissal
- (IBAction)backgroundTouch:(id)sender;
- (IBAction)textReturn:(id)sender;

@end
