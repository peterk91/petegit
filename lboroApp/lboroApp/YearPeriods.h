//
//  YearPeriods.h
//  lboroApp
//
//  Created by Peter Krepa on 15/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YearPeriods : NSManagedObject

@property (nonatomic, retain) NSDate * enddate;
@property (nonatomic, retain) NSString * week;
@property (nonatomic, retain) NSString * periodID;
@property (nonatomic, retain) NSDate * startdate;
@property (nonatomic, retain) NSString * semester;

@end
