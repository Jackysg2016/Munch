//
//  ViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

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
            
            
            NSString *urlString = @"https://api.yelp.com/v2/search?term=food&ll=37.788022,-122.399797";
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                
                
            }];
            
            [dataTask resume];
            
            
        }];
        


        
        
    }
    
    self.lastLocation = currentLocation;
    
}

@end
