//
//  ContainerClassViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ContainerClassViewController.h"
#import "DetailViewController.h"

@implementation ContainerClassViewController

-(void)viewDidLoad{
    


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"containerToDetailView"]){
        
        DetailViewController *DVC = (DetailViewController *)segue.destinationViewController;
        
       DVC.lastLocation = self.lastLocation;
        
        DVC.receivedRestaurant = self.receivedRestaurant;
        
        
    }
    

}

@end
