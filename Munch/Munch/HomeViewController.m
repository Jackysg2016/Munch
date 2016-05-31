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
    
}



//
-(void)updateSession:(int)sessionType{
    
    NSArray *userSettingsDataArray = [self fetchUserSettings];
    
    UserSettings *userSettings = [userSettingsDataArray firstObject];
    
    userSettings.sessionType = sessionType;
    
    NSError *error;
    [self.managedObjectContext save:&error];
    //saved session type as a user default so that next time the user pulls it up, it will still be the same session type unless changed at homescreen
}

-(NSArray *)fetchUserSettings{
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserSettings"];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


@end
