//
//  MunchViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-31.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "MunchViewController.h"

@interface MunchViewController ()

@end




@implementation MunchViewController


-(void)viewDidLoad{

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
