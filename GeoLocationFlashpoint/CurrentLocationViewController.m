//
//  CurrentLocationViewController.m
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 9/29/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import "NewLocations.h"
#import "AppDelegate.h"


@interface CurrentLocationViewController () 

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *lastLocationTimestamp;
//@property (strong, nonatomic) NSMutableArray *rows;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (void)suspendLocationUpdates;

- (void)saveLocation:(NSArray *)locations;

@end

@implementation CurrentLocationViewController


- (id)init
{
    if (self = [super init])
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self setLocationAccuracyBestDistanceFilterNone];
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];

        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;

        self.managedObjectContext = appDelegate.managedObjectContext;
   }
    return self;
}



- (void)setLocationAccuracyBestDistanceFilterNone
{
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
}


#pragma mark - CLLocationMangerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self saveLocation:locations];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}


- (void)saveLocation:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger theTimer = [defaults integerForKey:@"myTime"];
    NSLog(@"%li", (long)theTimer);

    if (theTimer <= 4) {
        theTimer = 5;
    } else {
        theTimer = theTimer;
    }
    long int x = theTimer;

    if (self.lastLocationTimestamp == nil)
    {
        self.lastLocationTimestamp = location.timestamp;

//Formats the location.timestamp to be more reader friendly
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMM dd, yyyy @ hh:mm:ss a"];
        NSString *dateString = [dateFormat stringFromDate:location.timestamp];
        NSLog(@"Date: %@", dateString);

        NSString *time = [NSString stringWithFormat:@"Time: %@" ,dateString];
        NewLocations * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"NewLocations"
                                                            inManagedObjectContext:self.managedObjectContext];
        newEntry.timestamp  = time;
        //NSLog(@"%@",newEntry);
    }




    else if ([location.timestamp timeIntervalSinceDate:self.lastLocationTimestamp] >= x)
    {
//       TODO: Do something with the location coördinates
 //      NSLog(@"Time %@: Lat: %f, Long: %f, Speed: %f, Course %f, Accuracy: %f",
//              location.timestamp,
//              location.coordinate.latitude,
//              location.coordinate.longitude,
//              location.speed,
//              location.course,
//              location.horizontalAccuracy);
        //NSLog(@"%@", locations);

//Formats the location.timestamp to be more reader friendly
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMM dd, yyyy @ hh:mm:ss a"];
        NSString *dateString = [dateFormat stringFromDate:location.timestamp];
        NSLog(@"Date: %@", dateString);
        NSString *time = [NSString stringWithFormat:@"%@" ,dateString];

        NSString *latitude = [NSString stringWithFormat:@"Latitude: %f degrees" ,location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"Longitude: %f degrees" ,location.coordinate.longitude];

//converts meters per sec into Miles per hour and then into an integer
         double speedMPH =  location.speed * 2.23694;
        if (speedMPH <= 0) {
            speedMPH = 0;
        }else {
            speedMPH = speedMPH;
        }
        int myIntSpeedMPH = (int)speedMPH;
        NSString *speed = [NSString stringWithFormat:@"Speed: %d MPH" ,myIntSpeedMPH];

        int myCourse = (int)location.course;
        if (myCourse <= 0) {
            myCourse = 0;
        }else {
            myCourse = myCourse;
        }

         NSString *course = [NSString stringWithFormat:@"Course: %d degrees" ,myCourse];

        int myAccuracy = (int)location.horizontalAccuracy;

        NSString *accuracy = [NSString stringWithFormat:@"Accuracy: %d meters" ,myAccuracy];

        NewLocations * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"NewLocations"
                                                          inManagedObjectContext:self.managedObjectContext];
        //NSLog(@"%@",newEntry);

        newEntry.course = course;
        newEntry.timestamp  = time;
        newEntry.accuracy = accuracy;
        newEntry.latitude = latitude;
        newEntry.longitude  = longitude;
        newEntry.speed = speed;
        NSError *error;
       NSLog(@"%@",newEntry);

        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        


        self.lastLocationTimestamp = location.timestamp;
        [self suspendLocationUpdates];
    }
}

- (void)suspendLocationUpdates
{
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    self.locationManager.distanceFilter = 99999;
}



@end
