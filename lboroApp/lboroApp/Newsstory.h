//
//  Newsstory.h
//  lboroApp
//
//  Created by Peter Krepa on 11/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Newsstory : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * link;

@end
