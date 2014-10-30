//
//  SecondViewController.h
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 10/2/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentLocationViewController.h"
#import "NewLocations.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface SecondViewController : UIViewController


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;



@property (nonatomic,strong)NSMutableArray* fetchedRecordsArray;
@property (nonatomic,strong)NSArray* fetchedRecords;
-(NSArray*)getAllLocationRecords;


@end
