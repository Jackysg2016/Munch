//
//  MunchViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-31.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "MunchViewController.h"


@interface MunchViewController ()

@property (weak, nonatomic) IBOutlet UIButton *munchNowButton;
@property (weak, nonatomic) IBOutlet UIButton *nopeButton;
@property (weak, nonatomic) IBOutlet UIButton *yuckButton;

//for button animation
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
  
}






#pragma mark - Button Action & Animation -

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
