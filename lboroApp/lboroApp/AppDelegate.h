//
//  AppDelegate.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LU_VC_loginPage.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property AVPlayer *audioPlayer;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
-(void)makeRadio;
- (NSURL *)applicationDocumentsDirectory;

@end
