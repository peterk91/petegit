//
//  LU_VC_addOption.h
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface LU_VC_addOption : UIViewController<UITableViewDelegate, UITableViewDataSource>
//outlets
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *alltableView;
//properties
@property NSMutableArray *tableData;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property BOOL isFiltered;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
//passsed properties
@property NSString *addType;
//actions
- (IBAction)cancelPressed:(id)sender;
- (IBAction)addOption:(id)sender;
@end
