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

@interface MunchViewController () <CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *munchNowButton;
@property (weak, nonatomic) IBOutlet UIButton *nopeButton;
@property (weak, nonatomic) IBOutlet UIButton *yuckButton;

@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *lastLocation;

@property (nonatomic) float buttonShrinkRatio;

@end




@implementation MunchViewController


-(void)viewDidLoad{
    
    self.buttonShrinkRatio = 0.8;
    
    NSArray *ButtonArray = @[self.munchNowButton,self.nopeButton,self.yuckButton];
    for (UIButton *button in ButtonArray){
        [button addTarget:self action:@selector(holdDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(holdRelease:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(holdReleaseOutside:) forControlEvents:UIControlEventTouchUpOutside];
        button.adjustsImageWhenHighlighted = NO;
    }

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    //Taylors stuff//
    self.restaurants = [[NSMutableArray alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
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
            NSString *lat = [NSString stringWithFormat:@"%f",place.location.coordinate.latitude];
            NSString *lon = [NSString stringWithFormat:@"%f",place.location.coordinate.longitude];
            NSString *coord = [NSString stringWithFormat:@"%@,%@", lat, lon ];
            
            YelpClient *client = [YelpClient new];
            
            NSDictionary *paramDictionary = @{
                                              @"term" : @"food",
                                              @"ll" : coord
                                              };
            
            //get the data!
            [client getPath:@"search" parameters:paramDictionary
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *objects = responseObject[@"businesses"];
                        for (NSDictionary *restaurant in objects) {
                            
                            //create restaurant objects
                            Restaurant *res = [[Restaurant alloc] initWithEntity:[NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext andDictionary:restaurant] ;
                            
                            [self.restaurants addObject:res];
                            
                            
                        }
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Restaurants didn't load! :(");
                    }];
        }];
    }
    
    self.lastLocation = currentLocation;
    
}



//munch Now button pressed, take user to Matched View Controller
- (IBAction)startMatchedView:(UIButton *)sender {
}

//nope button pressed, update cards
- (IBAction)showNextMunch:(UIButton *)sender {
}

//yuck button pressed, update cards and update yuck list
- (IBAction)yuckButtonPressed:(UIButton *)sender {
}

-(void)holdDown:(UIButton*) sender{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(self.buttonShrinkRatio,self.buttonShrinkRatio, 1);
                     }
                     completion:^(BOOL finished) {
                     }];
}

-(void)holdRelease:(UIButton *) sender{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.05
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              
                                              sender.layer.transform = CATransform3DMakeScale(1,1, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              //run segue
                                       }];
                     }];
}

-(void)holdReleaseOutside:(UIButton *)sender{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.05
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              sender.layer.transform = CATransform3DMakeScale(1,1, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              //dont run segue
                                          }];
                     }];
}


@end
