//
//  LU_VC_editClubEvent.h
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "AppDelegate.h"

@interface LU_VC_editClubEvent : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
//outlets
@property (weak, nonatomic) IBOutlet UIPickerView *buildingPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTimePicker;
@property (weak, nonatomic) IBOutlet UITextField *eventInfo;
//properties
@property NSMutableArray *buildings;
@property NSMutableArray *rooms;
//passed properties
@property NSManagedObjectContext *currentContext;
@property Event *passedEvent;
@property NSString *type;
@property BOOL addNew;
@property BOOL fromCal;
@property NSString *addeventid;
//actions
- (IBAction)startTimeChanged:(id)sender;
- (IBAction)endTimeChanged:(id)sender;
- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
//Keyboard Dismissal
- (IBAction)backgroundTouch:(id)sender;
- (IBAction)textReturn:(id)sender;
@end
