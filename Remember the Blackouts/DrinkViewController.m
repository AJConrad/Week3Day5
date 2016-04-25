//
//  DrinkViewController.m
//  Remember the Blackouts
//
//  Created by Andrew Conrad on 4/22/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import "DrinkViewController.h"
#import "LocationViewController.h"
#import "ViewController.h"
#import "Occasion.h"
#import "Drink.h"
#import "AppDelegate.h"

@interface DrinkViewController ()

@property (nonatomic, strong)               AppDelegate             *appDelegate;
@property (nonatomic, strong)               NSManagedObjectContext  *managedObjectContext;
@property (nonatomic, weak)     IBOutlet    UITextField             *drinkNameTextField;
@property (nonatomic, weak)     IBOutlet    UIStepper               *servingStepper;
@property (nonatomic, weak)     IBOutlet    UISlider                *percentageSlider;
@property (nonatomic, weak)     IBOutlet    UILabel                 *servingsLabel;
@property (nonatomic, weak)     IBOutlet    UILabel                 *percentageLabel;
@property (nonatomic, weak)     IBOutlet    UIDatePicker            *timeDatePicker;





@end

@implementation DrinkViewController


#pragma mark - User Control Methods

- (IBAction)servingChanged:(UIStepper *)stepper {
    _currentDrink.drinkAmounts = ([NSNumber numberWithDouble:stepper.value]);
    _servingsLabel.text = [NSString stringWithFormat:@"%@ servings", _currentDrink.drinkAmounts];
}

- (IBAction)percentageChanged:(UISlider *)slider {
    _currentDrink.drinkPercent = [NSNumber numberWithFloat:slider.value];
    _percentageLabel.text = [NSString stringWithFormat:@"%@ percent", _currentDrink.drinkPercent];
}

- (IBAction)saveButton:(UIBarButtonItem *)saver {
    _currentDrink.drinkNames = _drinkNameTextField.text;
    _currentDrink.drinkTime = _timeDatePicker.date;
    _currentDrink.drinkPercent = [NSNumber numberWithFloat:_percentageSlider.value];
    _currentDrink.drinkAmounts = [NSNumber numberWithFloat:_servingStepper.value];
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)trashButton:(UIBarButtonItem *)trasher {
    [_managedObjectContext deleteObject:_currentDrink];
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (_currentDrink == nil) {
        Drink *newDrink = (Drink *)[NSEntityDescription insertNewObjectForEntityForName:@"Drink" inManagedObjectContext:(_managedObjectContext)];
        _currentDrink = newDrink;
        _currentDrink.drinkPercent = [NSNumber numberWithFloat:0.0];
        _currentDrink.drinkAmounts = [NSNumber numberWithDouble:0];
        _currentDrink.drinkTime = [NSDate date];
        _currentDrink.drinkNames = @"";
        
    } else{
        _servingStepper.value = [_currentDrink.drinkAmounts doubleValue];
        _servingsLabel.text = [NSString stringWithFormat:@"%@ servings", _currentDrink.drinkAmounts];
        _percentageSlider.value = [_currentDrink.drinkPercent floatValue];
        _percentageLabel.text = [NSString stringWithFormat:@"%@ percent", _currentDrink.drinkPercent];
        _drinkNameTextField.text = _currentDrink.drinkNames;
        _timeDatePicker.date = _currentDrink.drinkTime;
        
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
