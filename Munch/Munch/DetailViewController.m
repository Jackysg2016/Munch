//
//  DetailViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITabBarItem *tabBarItem;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end

@implementation DetailViewController

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event //here enable the touch
{
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchLocation = [touch locationInView:self.view];
    if (CGRectContainsPoint(self.tabBar.frame, touchLocation))
    {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"Dismiss completed");
        }];
    }
}


- (IBAction)pressedMunchButton:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismiss completed");
    }];


}

@end
