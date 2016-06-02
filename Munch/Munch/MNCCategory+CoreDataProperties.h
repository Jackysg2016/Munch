//
//  MNCCategory+CoreDataProperties.h
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MNCCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNCCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *searchString;
@property (nullable, nonatomic, retain) NSSet<Filter *> *filters;

@end

@interface MNCCategory (CoreDataGeneratedAccessors)

- (void)addFiltersObject:(Filter *)value;
- (void)removeFiltersObject:(Filter *)value;
- (void)addFilters:(NSSet<Filter *> *)values;
- (void)removeFilters:(NSSet<Filter *> *)values;

@end

NS_ASSUME_NONNULL_END
