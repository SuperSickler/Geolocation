//
//  SecondViewController.m
//  GeoLocationFlashpoint
//
//  Created by Steven Sickler on 10/2/14.
//  Copyright (c) 2014 Flashpoint. All rights reserved.
//

#import "SecondViewController.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NewLocations.h"
#import "SimpleTableCell.h"

@interface SecondViewController ()  <UITableViewDataSource,UITableViewDataSource>



@property (strong,nonatomic) UITableView *myTableView;
@property(nonatomic, retain) UIColor *tintColor;
@property UIRefreshControl *refreshControl;
@property (weak, nonatomic) NSString *string;
@property (strong, nonatomic) IBOutlet UILabel *mySpeedLabel;


@end

@implementation SecondViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;

    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedRecordsArray = [appDelegate getAllLocationRecords].mutableCopy;
    [self.myTableView reloadData];


}



//- (IBAction)myRefreshButton
//{
//    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//
//    // Fetching Records and saving it in "fetchedRecordsArray" object
//    self.fetchedRecordsArray = [appDelegate getAllLocationRecords].mutableCopy;
//    [self.myTableView reloadData];
//
//}


#pragma mark - UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //add code here
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

return self.fetchedRecordsArray.count;

}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *simpleTableIdentifier = @"SimpleTableCell";

    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];


    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];    }

 //   NewLocations *record = [self.fetchedRecordsArray objectAtIndex:indexPath.row];

//    cell.timeLabel.text = [NSString stringWithFormat:@"%@",record.timestamp];
//    cell.latitudeLabel.text = [NSString stringWithFormat:@"%@",record.latitude];
//    cell.longitudeLabel.text = [NSString stringWithFormat:@"%@",record.longitude];
//    cell.speedLabel.text = [NSString stringWithFormat:@"%@",record.speed];
//    cell.courseLabel.text = [NSString stringWithFormat:@"%@",record.course];
//    cell.accuracyLabel.text = [NSString stringWithFormat:@"%@",record.accuracy];

    return cell;


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
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error].mutableCopy;

    // Returning Fetched Records
    return fetchedRecords;
}



//Accounts for customtableview cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 156;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    // Remove the row from data model
    [self.fetchedRecordsArray removeObjectAtIndex:indexPath.row];

    // Request table view to reload
    [tableView reloadData];

}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.myTableView beginUpdates];
}




@end
