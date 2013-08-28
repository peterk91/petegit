//
//  LU_VC_weekContent.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LU_VC_editModuleEvent.h"
#import "LU_VC_editClubEvent.h"

@interface LU_VC_weekContent : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSMutableArray *weekData;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDateFormatter *myDateFormatter;
@property NSMutableArray *theArray;
@property NSManagedObjectContext *currentContext;

@end
