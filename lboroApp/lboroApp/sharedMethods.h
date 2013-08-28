//
//  sharedMethods.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Module.h"
#import "AUClub.h"
#import "Society.h"
#import "LabelEdition.h"
#import "Event.h"
#import "TVSegment.h"
#import "YearPeriods.h"
#import "Newsstory.h"
#import "Room.h"
#import "Building.h"


@interface sharedMethods : NSObject

-(NSMutableArray *)connectPHPurl:(NSURL*)phpURL variables:(NSArray*)variables;
-(void)updateUserMOD:(Module*)module toDelete:(BOOL)del;
-(void)updateUserAU:(AUClub*)auclub toDelete:(BOOL)del;
-(void)updateUserSOC:(Society*)society toDelete:(BOOL)del;
-(void)getAllOptions;
-(void)getLabelData;
-(void)getTVData;
-(void)getEventData;
-(void)getYearPeriodsData;
-(void)getNewsData;
-(void)getLocations;
- (void)updateEvent:(Event *)event isNewEvent:(BOOL)isNew;
- (void)updateMODEvent:(Event *)event isNewEvent:(BOOL)isNew;
- (void)updateUserSelection:(Event*)event toDelete:(BOOL)del;

@property NSString *formatterstring;
@property NSString *path;

@property NSMutableString * newsTitle, * newsDate, * newsInfo, * newsURL;
@property NSString * elementRSS;
@property NSManagedObjectContext *newsContext;


@end
