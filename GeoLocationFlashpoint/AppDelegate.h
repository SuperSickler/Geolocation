//
//  AppDelegate.h
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 9/29/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentLocationViewController.h"
#import <CoreData/CoreData.h>


@class CurrentLocationViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
   CurrentLocationViewController *locationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) UIStoryboard* storyboard;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;
@property(strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;


-(NSArray*)getAllLocationRecords;

- (void)startTimer;
@end

