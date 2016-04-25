//
//  Drink+CoreDataProperties.h
//  Remember the Blackouts
//
//  Created by Andrew Conrad on 4/24/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Drink.h"

NS_ASSUME_NONNULL_BEGIN

@interface Drink (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *drinkAmounts;
@property (nullable, nonatomic, retain) NSString *drinkNames;
@property (nullable, nonatomic, retain) NSNumber *drinkPercent;
@property (nullable, nonatomic, retain) NSDate *drinkTime;
@property (nullable, nonatomic, retain) Occasion *relationshipDrinkOccasion;

@end

NS_ASSUME_NONNULL_END
