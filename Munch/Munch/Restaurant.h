//
//  Restaurant.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Deal, Image;

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant : NSManagedObject

-(void) addInfoFromDictionary:(NSDictionary *)info;

-(NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END

#import "Restaurant+CoreDataProperties.h"