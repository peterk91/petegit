//
//  LU_VC_campusRadio.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LU_VC_campusRadio : UIViewController

- (IBAction)playRadio:(id)sender;
- (IBAction)stopRadio:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property AppDelegate *theAppDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *helpImage;
- (IBAction)infoButton:(id)sender;

@end
