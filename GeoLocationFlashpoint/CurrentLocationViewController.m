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
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSData *dict;
@property (strong, nonatomic) NSMutableArray *reading;

@property (strong, nonatomic) NSMutableDictionary *locationDicOne;
@property int i;


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (void)suspendLocationUpdates;

- (void)saveLocation:(NSArray *)locations;

@end

@implementation CurrentLocationViewController {
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}


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

    NSUserDefaults *standardDefaults= [NSUserDefaults standardUserDefaults];

    if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"High"]) {
       [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
        NSLog(@"using High accuracy / navigation");
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];

    } else if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"Meduim"]) {
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        NSLog(@"using meduim accuracy / accuracy best");
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    } else if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"Low"]) {
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        NSLog(@"using low accuracy / accuracy kilometer");
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    } else {
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        NSLog(@"using default accuracy / accuracy best as default");
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    }

    //[self.locationManager setDistanceFilter:kCLDistanceFilterNone];
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

    NSLog(@"Last Object Location is %@", location);

    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger theTimer = [standardDefaults integerForKey:@"myTime"];

    long int x = theTimer;


    //sets timer to 10 when app is first used
    if (x <= 0) {
        x = 10;
    }
    //app must be restarted inorder for setting changes to take effect
    NSLog(@"timer in saving window is %li", x);


    if (self.lastLocationTimestamp == nil)
    {
        self.lastLocationTimestamp = location.timestamp;

    //Formats the location.timestamp to be more reader friendly
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMM dd, yyyy @ hh:mm:ss a"];
        NSString *dateString = [dateFormat stringFromDate:location.timestamp];
        //NSLog(@"%li", (long)theTimer);
        NSLog(@"First Date: %@", dateString);

        NSString *time = [NSString stringWithFormat:@"Time: %@" ,dateString];
        NewLocations * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"NewLocations"
                                                            inManagedObjectContext:self.managedObjectContext];
        newEntry.timestamp  = time;

    }

    else if ([location.timestamp timeIntervalSinceDate:self.lastLocationTimestamp] >= x
             )
    {

        NSLog(@" location timestamp is %@", location.timestamp);
        NSLog(@"last locationTimestamp is %@", self.lastLocationTimestamp);
        NSLog(@"RESULT VALUe IS %f", [location.timestamp timeIntervalSinceDate:self.lastLocationTimestamp]);

//       TODO: Do something with the location coördinates
//       NSLog(@"\n Time: %@, \n Lat: %f,\n Long: %f,\n Speed: %f,\n Course %f,\n Accuracy: %f",
//              location.timestamp,location.coordinate.latitude,location.coordinate.longitude,
//              location.speed,location.course,location.horizontalAccuracy);
//NSLog(@"Do something with the data  %@",location);

//Formats the location.timestamp to be more reader friendly
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMM dd, yyyy @ hh:mm:ss a"];
        NSString *dateString = [dateFormat stringFromDate:location.timestamp];
       // NSLog(@"Date: %@", dateString);
        NSString *time = [NSString stringWithFormat:@"%@",dateString];

        double latitude = location.coordinate.latitude;
       // NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        double longitude = location.coordinate.longitude;
      //  NSString *longitude = [NSString stringWithFormat:@"%f" ,location.coordinate.longitude];

//converts meters per sec into Miles per hour and then into an integer
         double speedMPH =  location.speed * 2.23694;
        if (speedMPH <= 0) {
            speedMPH = 0;
        }else {
            speedMPH = speedMPH;
        }
        int myIntSpeedMPH = (int)speedMPH;
       // NSString *speed = [NSString stringWithFormat:@"%d" ,myIntSpeedMPH];
        int myCourse = (int)location.course;
        if (myCourse <= 0) {
            myCourse = 0;
        }else {
            myCourse = myCourse;
        }
         //NSString *course = [NSString stringWithFormat:@"%d" ,myCourse];

        int myAccuracy = (int)location.horizontalAccuracy;
        NSLog(@"myAccuracy is %i",myAccuracy);
        //NSString *accuracy = [NSString stringWithFormat:@"%d" ,myAccuracy];
        
//BELOW SAVES TO CORE DATA

        if (myAccuracy <=0 || myAccuracy >=20) {
            NSLog(@"doing nothing");
        }else if ([location.timestamp timeIntervalSinceDate:self.lastLocationTimestamp] >=x){
            

            self->geocoder = [[CLGeocoder alloc] init];

            //NSLog(@"CClocation of last Object \n %@", location);


            // Reverse Geocoding
            NSLog(@"Resolving the Address");
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                // NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
                if (error == nil && [placemarks count] > 0) {
                    placemark = [placemarks lastObject];
                    NSLog(@"the info used to do geolocation%@", location);
                    NSLog(@"\n%@ \n%@ \n%@ \n%@\n%@\n%@",
                          placemark.subThoroughfare,
                          placemark.thoroughfare,
                          placemark.postalCode,
                          placemark.locality,
                          placemark.administrativeArea,
                          placemark.country);
                } else {
                NSLog(@"%@", error.debugDescription);
                }
                
            } ];

        NewLocations * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"NewLocations"
                                                          inManagedObjectContext:self.managedObjectContext];
        newEntry.course = myCourse; //int 32
        newEntry.timestamp  = time; // string
        newEntry.accuracy = myAccuracy; //int 32
        newEntry.latitude = latitude; //double
        newEntry.longitude  = longitude; //double
        newEntry.speed = myIntSpeedMPH; //int 16
        newEntry.subThoroughfare = placemark.subThoroughfare; //number
        newEntry.thoroughfare = placemark.thoroughfare; //string
        newEntry.postalCode = placemark.postalCode; //number
        newEntry.locality = placemark.locality; //string
        newEntry.administrativeArea = placemark.administrativeArea; //string
        newEntry.country = placemark.country; //string
       // newEntry.count = count;

            NSError *error;
            NSLog(@"New newEntry IS %@", newEntry);
            self.lastLocationTimestamp = location.timestamp;
            NSLog(@"location time stamp has been recorded as %@", location.timestamp);
            [self suspendLocationUpdates];
            NSLog(@"Suspending search");


        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }


//            self.lastLocationTimestamp = location.timestamp;
//            NSLog(@"location time stamp has been recorded as %@", location.timestamp);
//            [self suspendLocationUpdates];
//            NSLog(@"Suspending search");
        }
    }

}







- (void)suspendLocationUpdates
{
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    self.locationManager.distanceFilter = 99999;
    //self.locationManager.pausesLocationUpdatesAutomatically = YES;
    //self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
}


@end
