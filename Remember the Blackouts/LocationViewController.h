//
//  LocationViewController.h
//  Remember the Blackouts
//
//  Created by Andrew Conrad on 4/21/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Occasion.h"
#import "Drink.h"

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)   Occasion    *currentLocation;


@end
