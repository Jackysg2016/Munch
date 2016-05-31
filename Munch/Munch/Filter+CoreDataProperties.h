//
//  Filter+CoreDataProperties.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
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
@property (nullable, nonatomic, retain) NSSet<Category *> *pickedCategories;

@end

@interface Filter (CoreDataGeneratedAccessors)

- (void)addPickedCategoriesObject:(Category *)value;
- (void)removePickedCategoriesObject:(Category *)value;
- (void)addPickedCategories:(NSSet<Category *> *)values;
- (void)removePickedCategories:(NSSet<Category *> *)values;

@end

NS_ASSUME_NONNULL_END
