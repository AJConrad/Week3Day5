//
//  Occasion+CoreDataProperties.h
//  Remember the Blackouts
//
//  Created by Andrew Conrad on 4/24/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Occasion.h"

NS_ASSUME_NONNULL_BEGIN

@interface Occasion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *ocassionDateTime;
@property (nullable, nonatomic, retain) NSString *ocassionLocationGPS;
@property (nullable, nonatomic, retain) NSString *ocassionLocationName;
@property (nullable, nonatomic, retain) Drink *relationshipOccasionDrinks;

@end

NS_ASSUME_NONNULL_END
