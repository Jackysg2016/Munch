//
//  Restaurant.h
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Deal, Image;

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant : NSManagedObject

-(NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END

#import "Restaurant+CoreDataProperties.h"
