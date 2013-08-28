//
//  TVSegment.h
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TVSegment : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * url;

@end
