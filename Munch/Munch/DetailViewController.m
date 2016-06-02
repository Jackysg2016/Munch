//
//  DetailViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic) NSString *phoneNumberURLString;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *verbalLabel;

@end

@implementation DetailViewController

-(void)viewDidLoad{
    
    NSString *phoneNumber = self.receivedRestaurant.phoneNumber;
    if(phoneNumber) {
        self.phoneNumberURLString = [@"telprompt:://" stringByAppendingString:phoneNumber];
        [self.callButton addTarget:self action:@selector(holdDown:) forControlEvents:UIControlEventTouchDown];
        [self.callButton addTarget:self action:@selector(holdRelease:) forControlEvents:UIControlEventTouchUpInside];
        [self.callButton addTarget:self action:@selector(holdReleaseOutside:) forControlEvents:UIControlEventTouchUpOutside];
        self.callButton.adjustsImageWhenHighlighted = NO;
    } else {
        self.callButton.enabled = NO;
    }
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //remember to add mapkit and update plist with NSLocationWhenInUseUsageDescription
        [self.locationManager requestWhenInUseAuthorization];
    }
    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.lastLocation.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    [self createAnnots];
    
    self.imageView.image = self.receivedRestaurant.image;
    self.addressLabel.text = self.receivedRestaurant.address;
    self.verbalLabel.text = self.receivedRestaurant.verbalAddress;
    self.nameLabel.text = self.receivedRestaurant.name;
}

- (IBAction)backButtonPressed:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:^{
    }];


}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.lastLocation = [locations lastObject];
        
        //set map view on current location
        //MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
        
        //MKCoordinateRegion region = MKCoordinateRegionMake(self.lastLocation.coordinate, span);
        
        //[self.mapView setRegion:region animated:YES];
}





-(void)holdDown:(UIButton *)sender{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(0.80,0.80, 1);
                     }
                     completion:^(BOOL finished) {
                     }];
    
}

-(void)holdRelease:(UIButton *)sender{
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
                                              
                                              //makes phone call
                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.phoneNumberURLString]];
                                              
                                              
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
                                          }];
                     }];
}


- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *pin = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    pin.image = [UIImage imageNamed:@"marker"];
    
    
    if (!pin) {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pin.canShowCallout = YES;
        pin.image = [UIImage imageNamed:@"marker"];
    }
    
    return pin;
}


-(void)createAnnots{
    
    MKPointAnnotation *newAnnot = [[MKPointAnnotation alloc] init];
    newAnnot.coordinate = CLLocationCoordinate2DMake(self.receivedRestaurant.latitude, self.receivedRestaurant.longitude);
    
    [self.mapView addAnnotation:newAnnot];
    
}

@end
