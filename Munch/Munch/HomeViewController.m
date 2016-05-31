//
//  HomeViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-31.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "HomeViewController.h"
#import "UserSettings.h"


@interface HomeViewController ()

@property (nonatomic) UserSettings *userSettings;


@end

@implementation HomeViewController

-(void)viewDidLoad{
    
    //if first session
    
    //checks to see if previous UserSettings exist
    NSArray *userSettingsDataArray = [self fetchUserSettings];
    
    //if it doesnt, create it
    if([userSettingsDataArray count] == 0){
            UserSettings *newUserSettings = [NSEntityDescription insertNewObjectForEntityForName:@"UserSettings" inManagedObjectContext:self.managedObjectContext];
            NSError *error;
            [self.managedObjectContext save:&error];
        
    }
    
}




-(void)updateSession:(int)sessionType{
    
}

-(NSArray *)fetchUserSettings{
    
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserSettings"];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
}


@end
