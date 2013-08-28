//
//  Event.h
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSString * periodID;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * eventid;
@property (nonatomic, retain) NSString * starttime;
@property (nonatomic, retain) NSString * endtime;
@property (nonatomic, retain) NSString * databaseID;

@end
