//
//  ContainerClassViewController.h
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TempRestaurant.h"

@interface ContainerClassViewController : UIViewController

@property (nonatomic) CLLocation *lastLocation;
@property (nonatomic) TempRestaurant *receivedRestaurant;

@property (nonatomic) BOOL showMunchNowButton;

@end
