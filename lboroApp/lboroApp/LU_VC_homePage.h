//
//  LU_VC_homePage.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LU_VC_webView.h"
#import "LU_cell_dayViewCell.h"
#import "AppDelegate.h"
#import "sharedMethods.h"
#import "Newsstory.h"
#import "LU_VC_secureWebView.h"
#import "LU_VC_membershipPage.h"

@interface LU_VC_homePage : UIViewController<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, retain) UIPopoverController *myPopoverController;
- (IBAction)learnPressed:(id)sender;
- (IBAction)mapPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *helpImage;
@property UIPopoverController *popover;
@property NSMutableArray *dayViewData;
@property NSMutableArray *newsTableData;
- (IBAction)cashCred:(id)sender;
@property UIView *loadingView;
@property (weak, nonatomic) IBOutlet UITableView *newsTable;
- (IBAction)printCred:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *dayViewTable;
@property BOOL popup;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
- (IBAction)helpButton:(id)sender;
- (IBAction)settingsPopover:(id)sender;
- (IBAction)helpButton2:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *helpImage2;
@end
