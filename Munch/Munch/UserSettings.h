//
//  UserSettings.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Filter, Restaurant;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,currentSessionType){
    justMunch,
    pickieMunch,
    cravieMunch,
    thriftyMunch,
    dareMeMunch
};

@interface UserSettings : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "UserSettings+CoreDataProperties.h"
