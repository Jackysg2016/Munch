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

@end




@implementation MunchViewController


-(void)viewDidLoad{

    [self.munchNowButton addTarget:self action:@selector(holdDown) forControlEvents:UIControlEventTouchDown];
    [self.munchNowButton addTarget:self action:@selector(holdRelease) forControlEvents:UIControlEventTouchUpInside];
    [self.munchNowButton addTarget:self action:@selector(holdReleaseOutside) forControlEvents:UIControlEventTouchUpOutside]; //add this for your case releasing the finger out side of the button's frame

}

//munch Now button pressed, take user to Matched View Controller
- (IBAction)startMatchedView:(UIButton *)sender {
    NSLog(@"startMatchedView");
}

//nope button pressed, update cards
- (IBAction)showNextMunch:(UIButton *)sender {
}

//yuck button pressed, update cards and update yuck list
- (IBAction)yuckButtonPressed:(UIButton *)sender {


}

-(void)holdDown{
    
    NSLog(@"holdDown");
}

-(void)holdRelease{
    
    NSLog(@"holdRelease");
}

-(void)holdReleaseOutside{
    
    NSLog(@"holdReleaseOutside");
}
@end
