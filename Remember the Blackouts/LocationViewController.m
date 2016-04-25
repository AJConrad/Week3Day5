//
//  LocationViewController.m
//  Remember the Blackouts
//
//  Created by Andrew Conrad on 4/21/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import "LocationViewController.h"
#import "ViewController.h"
#import "Occasion.h"
#import "Drink.h"
#import "AppDelegate.h"
#import "DrinkViewController.h"

@interface LocationViewController ()

@property (nonatomic, strong)               AppDelegate             *appDelegate;
@property (nonatomic, strong)               NSManagedObjectContext  *managedObjectContext;
@property (nonatomic, weak)     IBOutlet    UITextField             *nameTextField;
@property (nonatomic, weak)     IBOutlet    UITextField             *gpsTextField;
@property (nonatomic, weak)     IBOutlet    UIDatePicker            *startDatePicker;
@property (nonatomic, weak)     IBOutlet    UIButton                *addDrinkButton;
@property (nonatomic, strong)   IBOutlet    UITableView             *drinksTableView;
@property (nonatomic, strong)               NSArray                 *drinksArray;

@end

@implementation LocationViewController

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DrinkViewController *destController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"drinkEditor"]) {
        NSIndexPath *indexPath = [_drinksTableView indexPathForSelectedRow];
        Drink *selectedDrink = _drinksArray[indexPath.row];
        destController.currentDrink = selectedDrink;
        
    } else if ([[segue identifier] isEqualToString:@"drinkAdder"]) {
        destController.currentDrink = nil;
    }
}




#pragma mark - Table View Methods


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _drinksArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *iCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"DrinkCell" forIndexPath:indexPath];
    
    Drink *currentDrink = _drinksArray[indexPath.row];
    iCell.textLabel.text = [currentDrink drinkNames];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM d, H:mm a";
    iCell.detailTextLabel.text = [formatter stringFromDate:currentDrink.drinkTime];
    
    return iCell;

}


- (NSArray *)fetchDrinks {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Drink" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"drinkTime" ascending:true];
    [fetchRequest setSortDescriptors:@[sortDescriptor1]];
    
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
}

- (IBAction)saveButton:(UIBarButtonItem *)saver {
    _currentLocation.ocassionDateTime = _startDatePicker.date;
    _currentLocation.ocassionLocationGPS = _gpsTextField.text;
    _currentLocation.ocassionLocationName = _nameTextField.text;
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)trashButton:(UIBarButtonItem *)trasher {
    [_managedObjectContext deleteObject:_currentLocation];
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}



#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _drinksArray = [self fetchDrinks];
    [_drinksTableView reloadData];
    
    if (_currentLocation == nil) {
        Occasion *newOccasion = (Occasion *)[NSEntityDescription insertNewObjectForEntityForName:@"Occasion" inManagedObjectContext:(_managedObjectContext)];
        _currentLocation = newOccasion;
        _startDatePicker.date = [NSDate date];
        _nameTextField.text = @"";
        _gpsTextField.text = @"";
    } else {
        _startDatePicker.date = _currentLocation.ocassionDateTime;
        _gpsTextField.text = _currentLocation.ocassionLocationGPS;
        _nameTextField.text = _currentLocation.ocassionLocationName;
        
        for (Drink *drink in _drinksArray) {
            NSLog(@" %@, %@.",drink.drinkNames, drink.drinkPercent);
        }
        
        
        
    }
    
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
