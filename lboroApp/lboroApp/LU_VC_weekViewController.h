//
//  LU_VC_weekViewController.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LU_VC_weekContent.h"

@interface LU_VC_weekViewController : UIViewController<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property NSMutableArray *wholeArray;
@property NSManagedObjectContext *currentContext;

@end
