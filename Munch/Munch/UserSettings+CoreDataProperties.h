//
//  UserSettings+CoreDataProperties.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserSettings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *lastManualLocation;
@property (nonatomic) int64_t sessionType;
@property (nullable, nonatomic, retain) NSSet<Filter *> *cravieFilters;
@property (nullable, nonatomic, retain) NSSet<Filter *> *pickieFilters;
@property (nullable, nonatomic, retain) NSSet<Restaurant *> *matchedRestaurants;
@property (nullable, nonatomic, retain) NSSet<Restaurant *> *yuckRestaurants;
@property (nullable, nonatomic, retain) Filter *lastFilter;

@end

@interface UserSettings (CoreDataGeneratedAccessors)

- (void)addCravieFiltersObject:(Filter *)value;
- (void)removeCravieFiltersObject:(Filter *)value;
- (void)addCravieFilters:(NSSet<Filter *> *)values;
- (void)removeCravieFilters:(NSSet<Filter *> *)values;

- (void)addPickieFiltersObject:(Filter *)value;
- (void)removePickieFiltersObject:(Filter *)value;
- (void)addPickieFilters:(NSSet<Filter *> *)values;
- (void)removePickieFilters:(NSSet<Filter *> *)values;

- (void)addMatchedRestaurantsObject:(Restaurant *)value;
- (void)removeMatchedRestaurantsObject:(Restaurant *)value;
- (void)addMatchedRestaurants:(NSSet<Restaurant *> *)values;
- (void)removeMatchedRestaurants:(NSSet<Restaurant *> *)values;

- (void)addYuckRestaurantsObject:(Restaurant *)value;
- (void)removeYuckRestaurantsObject:(Restaurant *)value;
- (void)addYuckRestaurants:(NSSet<Restaurant *> *)values;
- (void)removeYuckRestaurants:(NSSet<Restaurant *> *)values;

@end

NS_ASSUME_NONNULL_END
