//
//  AppDelegate.m

//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 9/29/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import "AppDelegate.h"
#import "CurrentLocationViewController.h"

@interface AppDelegate ()


@end



@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


//      self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    locationController = [[CurrentLocationViewController alloc] init];

    [self startTimer];

//    self.window.backgroundColor = [UIColor blueColor];
//    [self.window makeKeyAndVisible];

//below is first screen presented in App which will be used as a splashscreen
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    //bewlow is first interactive screen for the application as noted by the identifier for the second view controller
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FlashbackID"];
    self.navigationController  = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.viewController];
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];



    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler: ^{ }];
    //[self startTimer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




- (void)startTimer
{


    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger theTimer = [standardDefaults integerForKey:@"myTime"];

    long int x = theTimer;

    NSLog(@"timer set to %li", x);



//sets timer to 10 when app is first used
        if (x <= 0) {
            x = 10;
        }
//app must be restarted inorder for setting changes to take effect
NSLog(@"timer has changed to to %li", x);


    self.timer = [NSTimer scheduledTimerWithTimeInterval:x
                                                  target:self->locationController
                                                selector:@selector(setLocationAccuracyBestDistanceFilterNone)
                                                userInfo:nil
                                                 repeats:YES];


}

// 1
- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }

    return _managedObjectContext;
}

//2
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];

    return _managedObjectModel;
}

//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"Locations.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSArray*)getAllLocationRecords
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NewLocations"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;

    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    // Returning Fetched Records
    return fetchedRecords;
}




@end
