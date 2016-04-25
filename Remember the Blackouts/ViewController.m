//
//  ViewController.m
//  Remember the Blackouts
//
//  Created by Andrew Conrad on 4/21/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import "ViewController.h"
#import "Occasion.h"
#import "Drink.h"
#import "AppDelegate.h"
#import "LocationViewController.h"
#import "DrinkViewController.h"

@interface ViewController ()

@property (nonatomic, strong)   NSManagedObjectContext      *managedObjectContext;
@property (nonatomic, strong)   AppDelegate                 *appDelegate;
@property (nonatomic, strong)   NSArray                     *locationsArray;
@property (nonatomic, strong)   IBOutlet    UITableView     *locationTableView;

@end

@implementation ViewController

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationViewController *destController = [segue destinationViewController];
        if ([[segue identifier] isEqualToString:@"LocationEditor"]) {
            NSIndexPath *indexPath = [_locationTableView indexPathForSelectedRow];
            Occasion *selectedLocation = _locationsArray [indexPath.row];
            destController.currentLocation = selectedLocation;
    
        } else if ([[segue identifier] isEqualToString:@"LocationAdder"]) {
            destController.currentLocation = nil;
        }
    }

#pragma mark - Table View Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _locationsArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *iCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    
    Occasion *currentLocation = _locationsArray[indexPath.row];
    iCell.textLabel.text = [currentLocation ocassionLocationName];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd-yyyy HH:mm";
    iCell.detailTextLabel.text = [formatter stringFromDate:currentLocation.ocassionDateTime];
    
    //should color by number of drinks, like green 1 or 2, yellow 3-5, and red 6+
    //may need to be a new attribute of the occasion entity

    return iCell;
}


#pragma mark - Temporary Data Addition
//command for adding data specified here is in the view did load section

- (void)tempAddData {
    Occasion *newOccasion = (Occasion *)[NSEntityDescription insertNewObjectForEntityForName:@"Occasion" inManagedObjectContext:(_managedObjectContext)];
    [newOccasion setOcassionLocationName:@"The Arena"];
    [newOccasion setOcassionLocationGPS:@"123.59 x 201.42"];
    [newOccasion setOcassionDateTime:[NSDate date]];
    
    Drink *drink1 = (Drink *)[NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:_managedObjectContext];
    [drink1 setDrinkTime:[NSDate dateWithTimeIntervalSinceNow: 60*60]];
    [drink1 setDrinkNames:@"Lynchburg Lemonade"];
    [drink1 setDrinkAmounts:@2];
    [drink1 setDrinkPercent:@21];
    drink1.relationshipDrinkOccasion = newOccasion;
    
    [_appDelegate saveContext];
    
}


#pragma mark - Core Data Methods

- (NSArray *)fetchOccasions {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Occasion" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];

    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"ocassionDateTime" ascending:false];
    [fetchRequest setSortDescriptors:@[sortDescriptor1]];

    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
}

- (void)refreshDataAndTable {
    _locationsArray = [self fetchOccasions];
    [_locationTableView reloadData];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
//    [self tempAddData];
//for adding the temp data
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshDataAndTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
