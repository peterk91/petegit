//
//  AUClub.h
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AUClub : NSManagedObject

@property (nonatomic, retain) NSString * databaseID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * chosen;

@end
