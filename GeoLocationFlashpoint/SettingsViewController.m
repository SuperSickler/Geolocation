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

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger theTimer = [defaults integerForKey:@"myTime"];
    self.numberOfSeconds.text = [NSString stringWithFormat:@"%i",theTimer];



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
@end
