//
//  DetailViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import "TempRestaurant.h"

@interface DetailViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic)  CLLocation *currentLocation;

@property (nonatomic) NSString *phoneNumberURLString;


@end

@implementation DetailViewController

-(void)viewDidLoad{
    
    self.phoneNumberURLString = @"telprompt:://+16043158701";
    
    [self.callButton addTarget:self action:@selector(holdDown:) forControlEvents:UIControlEventTouchDown];
    [self.callButton addTarget:self action:@selector(holdRelease:) forControlEvents:UIControlEventTouchUpInside];
    [self.callButton addTarget:self action:@selector(holdReleaseOutside:) forControlEvents:UIControlEventTouchUpOutside];
    self.callButton.adjustsImageWhenHighlighted = NO;
    
   
    
    TempRestaurant *test = [[TempRestaurant alloc]init];
    [self createAnnots:test];
    
    
    
    
    
}

- (IBAction)backButtonPressed:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:^{
    }];


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


-(void)createAnnots:(TempRestaurant *)tempRestaurant{
    
    MKPointAnnotation *newAnnot = [[MKPointAnnotation alloc] init];
    newAnnot.coordinate = CLLocationCoordinate2DMake(49.214257, -123.068717);
    
    [self.mapView addAnnotation:newAnnot];
    
}

@end
