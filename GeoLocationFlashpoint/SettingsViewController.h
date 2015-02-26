//
//  SettingsViewController.h
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 10/11/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *numberOfSeconds;
@property int number;
@property UIAlertView *rulesToSave;
@end
