//
//  Filter+CoreDataProperties.h
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Filter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Filter (CoreDataProperties)

@property (nonatomic) BOOL filterByExclusion;
@property (nonatomic) int64_t maxPricing;
@property (nonatomic) int64_t minRating;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<MNCCategory *> *pickedCategories;

@end

@interface Filter (CoreDataGeneratedAccessors)

- (void)addPickedCategoriesObject:(MNCCategory *)value;
- (void)removePickedCategoriesObject:(MNCCategory *)value;
- (void)addPickedCategories:(NSSet<MNCCategory *> *)values;
- (void)removePickedCategories:(NSSet<MNCCategory *> *)values;

@end

NS_ASSUME_NONNULL_END
