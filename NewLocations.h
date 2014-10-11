//
//  NewLocations.h
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 10/6/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewLocations : NSManagedObject

@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * accuracy;
@property (nonatomic, retain) NSString * course;
@property (nonatomic, retain) NSString * speed;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;

@end
