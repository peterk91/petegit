//
//  Event.h
//  lboroApp
//
//  Created by Peter Krepa on 15/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSString * chosen;
@property (nonatomic, retain) NSString * databaseID;
@property (nonatomic, retain) NSDate * endtime;
@property (nonatomic, retain) NSString * eventid;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * periodID;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSDate * starttime;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * week;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * startPeriod;
@property (nonatomic, retain) NSString * periodLength;
@property (nonatomic, retain) NSString * day;

@end
