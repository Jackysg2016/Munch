//
//  MunchViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-31.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "MunchViewController.h"
#import <MapKit/MapKit.h>
#import "YelpClient.h"
#import "Restaurant.h"
#import "AppDelegate.h"
#import "MNCCategory.h"
#import "RestaurantCardFactory.h"
#import "FilterView.h"
#import "UserSettings.h"

@interface MunchViewController () <CLLocationManagerDelegate>


@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *lastLocation;

@property (nonatomic) float buttonShrinkRatio;

@property (weak, nonatomic) IBOutlet RestaurantCardFactory *restaurantFactory;

@property (weak, nonatomic) IBOutlet FilterView *filterView;
@property (weak, nonatomic) IBOutlet UIButton *filterTabButton;
@property (weak, nonatomic) IBOutlet UIView *dimView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *labelBar1;
@property (weak, nonatomic) IBOutlet UIView *labelBar2;

@end




@implementation MunchViewController


-(void)viewDidLoad{
    
    self.buttonShrinkRatio = 0.8;

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    //Taylors stuff//
    self.restaurants = [[NSMutableArray alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.filterView.layer.cornerRadius = 7;
    self.filterView.layer.shadowRadius = 4;
    self.filterView.layer.shadowOpacity = 0.2;
    self.filterView.layer.shadowOffset = CGSizeMake(0.0f, 3.0);

    NSArray *array;
   [self.filterView setUpCategoryArray:array];
    
  
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    //logic to determine view of mode when starting this view
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserSettings"];
    NSArray *userSettingsDataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    UserSettings *userSettings = [userSettingsDataArray firstObject];
    
    if(userSettings.sessionType == 0){
        [self closeFilter];
    } else {
        [self openFilter];
    }

}


-(void)viewWillDisappear:(BOOL)animated{
    [self closeFilter];
}

#pragma mark - Button Action & Animation -

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations firstObject];
    
    if (self.lastLocation == nil) {
        
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        
        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //get current coordinates. eventually in seperate function to change search results based on filter
            CLPlacemark *place = [placemarks firstObject];

            NSMutableSet *testCategories = [[NSMutableSet alloc] init];
            [testCategories addObject:@"mexican"];
            [testCategories addObject:@"vegetarian"];
            [testCategories addObject:@"vegan"];
            
            NSDictionary *paramDictionary = [self getParamDictionaryWithPlace:place includeFilterCategories:YES withCategoryList:testCategories];
            
            YelpClient *client = [YelpClient new];
            
            //get the data!
            [client getPath:@"search" parameters:paramDictionary
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *objects = responseObject[@"businesses"];
                        for (NSDictionary *restaurant in objects) {
                            
                            //create restaurant objects
                            Restaurant *res = [[Restaurant alloc] initWithEntity:[NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext andDictionary:restaurant] ;
                            
                            [self.restaurants addObject:res];
                            
                        }
                        [self.restaurantFactory loadRestaurantCardsWithData:self.restaurants];
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Restaurants didn't load! :(");
                    }];
        }];
    }
    
    self.lastLocation = currentLocation;
    
}

-(NSDictionary *) getParamDictionaryWithPlace:(CLPlacemark *)place includeFilterCategories:(BOOL)state withCategoryList:(NSSet *)categories {
    
    //Get Current Lat & Long//
    NSString *lat = [NSString stringWithFormat:@"%f",place.location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",place.location.coordinate.longitude];
    NSString *coord = [NSString stringWithFormat:@"%@,%@", lat, lon ];
    
    //Set up basic parameters
    NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] init];
    paramDictionary[@"term"] = @"food,restaurant";
    paramDictionary[@"ll"] = coord;
    
    //If the filter includes categories to search for
    if (state) {
        NSArray *catArray = [categories allObjects];
        NSString *catString = [catArray componentsJoinedByString:@","];
        paramDictionary[@"category_filter"] = catString;
    }
    
    return paramDictionary;
}

- (IBAction)pressedFilterTab:(UIButton *)sender {
    
    if(self.filterHeightConstraint.constant == 0.0){
        
        [self openFilter];
        
    } else {
        
        [self closeFilter];
        
    }
}

//CLOSE FILTER FUNCTION
-(void)closeFilter{
    
    self.filterHeightConstraint.constant = 0.0;
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.dimView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];

   [UIView animateWithDuration:0.5
                      delay:0
                    options:UIViewAnimationOptionCurveEaseInOut
                 animations:^{
                     [self.view layoutIfNeeded];
                 }
                 completion:^(BOOL finished) {
                     
                 }];

}

-(void)openFilter{
    self.filterHeightConstraint.constant = self.view.frame.size.height * 0.8;
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.dimView.alpha = 0.2;
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                     }];

}

//DIM TOUCH CLOSES FILTER
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event //here enable the touch
{
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchLocation = [touch locationInView:self.view];
    if (CGRectContainsPoint(self.dimView.frame, touchLocation))
    {
        [self closeFilter];
    }
}

@end
