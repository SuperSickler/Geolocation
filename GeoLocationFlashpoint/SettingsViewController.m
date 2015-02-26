//
//  SettingsViewController.m
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 10/11/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *accuracySwitch;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];


    NSUserDefaults *standardDefaults= [NSUserDefaults standardUserDefaults];
    NSInteger theTimer = [standardDefaults integerForKey:@"myTime"];
    self.numberOfSeconds.text = [NSString stringWithFormat:@"%li",(long)theTimer];
    if ([self.numberOfSeconds.text isEqual:@"0"]) {
        self.mySlider.value = 10;
        self.numberOfSeconds.text = @"10";

    }else {

        self.mySlider.value = theTimer;
    }

    if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"High"]) {
        self.accuracySwitch.selectedSegmentIndex = 0;
    } else if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"Meduim"]) {
        self.accuracySwitch.selectedSegmentIndex = 1;
    } else if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"Low"]) {
        self.accuracySwitch.selectedSegmentIndex = 2;
    }

}

- (IBAction)onSlideAdjustTimeValue:(id)sender
{
    int number = self.mySlider.value;
    self.numberOfSeconds.text = [NSString stringWithFormat:@"%i",number];


    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    if (standardUserDefaults) {
        [standardUserDefaults setInteger:number forKey:@"myTime"];
        [standardUserDefaults synchronize];

    }

}

-(IBAction)toggleControl:(UISegmentedControl *)control
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if (control.selectedSegmentIndex == 0) {

        NSLog(@"High Selected");
        [standardDefaults setObject:@"High" forKey:@"distanceSettingKey"];


    } else if (control.selectedSegmentIndex ==1){
        NSLog(@"Meduim Selected");
        [standardDefaults setObject:@"Meduim" forKey:@"distanceSettingKey"];

    }else if (control.selectedSegmentIndex ==2) {
        NSLog(@"Low Selected");
        [standardDefaults setObject:@"Low" forKey:@"distanceSettingKey"];
    }
    [standardDefaults synchronize];
}
- (IBAction)saveSettings:(id)sender{

    self.rulesToSave = [[UIAlertView alloc] initWithTitle:@"Save Settings"
                                                              message:[NSString stringWithFormat:@"In order for these new settings to take effect and changed permenantly you must close this application entirely and re-launch it.  Thank you"]
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
    [self.rulesToSave show];
}

@end
