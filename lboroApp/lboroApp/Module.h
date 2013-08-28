//
//  Module.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Module : NSManagedObject

@property (nonatomic, retain) NSString * chosen;
@property (nonatomic, retain) NSString * databaseID;
@property (nonatomic, retain) NSString * moduleID;
@property (nonatomic, retain) NSString * title;

@end
