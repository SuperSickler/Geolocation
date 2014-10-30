//
//  SecondViewController.h
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 9/29/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SecondViewController.h"
#import "SettingsViewController.h"

@interface CurrentLocationViewController :  NSObject <CLLocationManagerDelegate>


/**
 * Set the accuracy of the location manager.
 */
- (void)setLocationAccuracyBestDistanceFilterNone;


@end