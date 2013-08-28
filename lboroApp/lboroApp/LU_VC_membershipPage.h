//
//  LU_VC_membershipPage.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LU_VC_addOption.h"
#import "LU_VC_optionEvents.h"
#import "LU_VC_navController.h"

@interface LU_VC_membershipPage : UIViewController<UITableViewDelegate, UITableViewDataSource>
//outlets
@property (weak, nonatomic) IBOutlet UIButton *addMod;
@property (weak, nonatomic) IBOutlet UIButton *addAU;
@property (weak, nonatomic) IBOutlet UIButton *addSoc;
@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
@property (weak, nonatomic) IBOutlet UIImageView *helpImage;
//properties
@property (nonatomic, retain) NSMutableArray *optionsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSString *addType;
@property NSString *typePassing;
//actions
- (IBAction)addOption:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)infoButton:(id)sender;
@end
