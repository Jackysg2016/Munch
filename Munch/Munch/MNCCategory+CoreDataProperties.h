//
//  MNCCategory+CoreDataProperties.h
//  
//
//  Created by Taylor Benna on 2016-06-01.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MNCCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNCCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *searchString;

@end

NS_ASSUME_NONNULL_END
