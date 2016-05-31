////
////  ViewController.m
////  Munch
////
////  Created by Enoch Ng on 2016-05-30.
////  Copyright © 2016 Enoch Ng. All rights reserved.
////
//
//#import "ViewController.h"
//#import "RestaurantCardFactory.h"
//#import <MapKit/MapKit.h>
//#import "YelpClient.h"
//#import "Restaurant.h"
//
//@interface ViewController () <CLLocationManagerDelegate>
//
//@property (nonatomic) CLLocationManager *locationManager;
//@property (nonatomic) CLLocation *lastLocation;
//
//@property (nonatomic) RestaurantCardFactory *factory;
//@property (nonatomic) NSMutableArray *restaurants;
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.restaurants = [[NSMutableArray alloc] init];
//    
//    _factory = [[RestaurantCardFactory alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    
//    [self.view addSubview:_factory];
//    
//    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//}
//
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
//    
//    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [self.locationManager startUpdatingLocation];
//    }
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    
//    CLLocation *currentLocation = [locations firstObject];
//    
//    if (self.lastLocation == nil) {
//        
//        CLGeocoder *coder = [[CLGeocoder alloc] init];
//        
//        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//            
//            CLPlacemark *place = [placemarks firstObject];
//            NSString *lat = [NSString stringWithFormat:@"%f",place.location.coordinate.latitude];
//            NSString *lon = [NSString stringWithFormat:@"%f",place.location.coordinate.longitude];
//            NSString *coord = [NSString stringWithFormat:@"%@,%@", lat, lon ];
//            
//            YelpClient *client = [YelpClient new];
//            
//            NSDictionary *paramDictionary = @{
//                                              @"term" : @"food",
//                                              @"ll" : coord
//                                              };
//            
//            [client getPath:@"search" parameters:paramDictionary
//                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                        NSDictionary *objects = responseObject[@"businesses"];
//                        for (NSDictionary *restaurant in objects) {
//                            
//                            //create restaurant objects
//                            Restaurant *res = [[Restaurant alloc] initWithDictionary:restaurant];
//                            
//                            NSLog(@"%@", res.name);
//                            
//                            [self.restaurants addObject:res];
//                            
//                        }
//                    }
//                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                        NSLog(@"Restaurants didn't load! :(");
//                    }];
//        }];
//    }
//    
//    self.lastLocation = currentLocation;
//    NSLog(@"%@", self.restaurants[0]);
//    
//}
//
//@end
