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
@property int accuracy;
@property int course;
@property int speed;
@property double latitude;
@property double longitude;
@property (nonatomic,retain) NSString *subThoroughfare;
@property (nonatomic,retain) NSString *thoroughfare;
@property (nonatomic,retain) NSString *postalCode;
@property (nonatomic,retain) NSString *locality;
@property (nonatomic,retain) NSString *administrativeArea;
@property (nonatomic,retain) NSString *country;

@property (nonatomic, retain) NSString * count;
@end
