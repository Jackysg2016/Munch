//
//  HomeViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-31.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "HomeViewController.h"
#import "UserSettings.h"
#import "AppDelegate.h"
#import "MunchViewController.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cravieButton;
@property (weak, nonatomic) IBOutlet UIButton *pickieButton;
@property (weak, nonatomic) IBOutlet UIButton *justMunchButton;

@property (nonatomic) UserSettings *userSettings;

@end

@implementation HomeViewController

-(void)viewDidLoad{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSArray *buttonArray = @[self.justMunchButton,self.cravieButton,self.pickieButton];
    
    for(UIButton *button in buttonArray){
        [button addTarget:self action:@selector(holdDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(holdRelease:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(holdReleaseOutside:) forControlEvents:UIControlEventTouchUpOutside];
        button.adjustsImageWhenHighlighted = NO;
    }
    


}


//
-(void)updateSession:(int)sessionType{
    
    NSArray *userSettingsDataArray = [self fetchUserSettings];
    
    self.userSettings = [userSettingsDataArray firstObject];
    
    self.userSettings.sessionType = sessionType;
    
    NSError *error;
    [self.managedObjectContext save:&error];
    //saved session type as a user default so that next time the user pulls it up, it will still be the same session type unless changed at homescreen
}

-(NSArray *)fetchUserSettings{
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserSettings"];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
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
                                              
                                              if([sender isEqual:self.justMunchButton]){
                                                  [self updateSession:0];
                                                  NSLog(@"changed to just munch mode %lli", self.userSettings.sessionType);
                                                  
                                              } else if([sender isEqual:self.pickieButton]){
                                                  [self updateSession:1];
                                                  NSLog(@"changed to pickie mode %lli", self.userSettings.sessionType);
                                                  
                                              } else if([sender isEqual:self.cravieButton]){
                                                  [self updateSession:2];
                                                  NSLog(@"changed to cravie mode %lli", self.userSettings.sessionType);
                                                  [self makeFilterDrop];
                                                  
                                              }
                                              
                                              self.tabBarController.selectedIndex = 1;
                                              
                                          }];
                     }];
    
}

-(void)makeFilterDrop {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:@"dropFilter"];
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
