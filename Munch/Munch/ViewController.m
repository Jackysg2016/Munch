//
//  ViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "YelpClient.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *lastLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

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
            
            CLPlacemark *place = [placemarks firstObject];
            NSString *lat = [NSString stringWithFormat:@"%f",place.location.coordinate.latitude];
            NSString *lon = [NSString stringWithFormat:@"%f",place.location.coordinate.longitude];
            NSString *coord = [NSString stringWithFormat:@"%@,%@", lat, lon ];
            
            YelpClient *client = [YelpClient new];
            
            NSDictionary *paramDictionary = @{
                                              @"term" : @"food",
                                              @"ll" : coord
                                              };
            
            [client getPath:@"search" parameters:paramDictionary
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *objects = responseObject[@"businesses"];
                        for (NSDictionary *res in objects) {
                            NSLog(@"%@", res[@"name"]);
                        }
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Oops");
                    }];
           
        }];
        
        
    }
    
    self.lastLocation = currentLocation;
    
}

@end
