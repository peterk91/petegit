//
//  Room.h
//  lboroApp
//
//  Created by Peter Krepa on 12/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * buildingid;
@property (nonatomic, retain) NSString * roomid;
@property (nonatomic, retain) NSString * name;

@end
