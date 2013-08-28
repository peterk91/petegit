//
//  LU_VC_optionEvents.h
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Module.h"
#import "AUClub.h"
#import "Society.h"
#import "AppDelegate.h"
#import "Event.h"
#import "LU_VC_editModuleEvent.h"
#import "LU_VC_editClubEvent.h"
#import "LU_cell_eventCell.h"

@interface LU_VC_optionEvents : UIViewController<UITableViewDelegate, UITableViewDataSource>
//outlets
@property (weak, nonatomic) IBOutlet UIImageView *helpImage;
@property (weak, nonatomic) IBOutlet UITableView *eventTableView;
//properties
@property NSMutableArray *tableData;
@property NSManagedObjectContext *currentContext;
@property BOOL addNew;
@property NSString *optionID;
@property NSInteger rowsel;
@property NSString *semPassed;
//passed properties
@property Module *passedMOD;
@property AUClub *passedAU;
@property Society *passedSOC;
@property NSString *typePassed;
//actions
- (IBAction)addButton:(id)sender;
- (IBAction)donePressed:(id)sender;
- (IBAction)infoPressed:(id)sender;

@end
