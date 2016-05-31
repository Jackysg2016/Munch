//
//  Restaurant+CoreDataProperties.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Restaurant.h"

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int64_t pricing;
@property (nonatomic) float rating;
@property (nullable, nonatomic, retain) NSString *verbalAddress;
@property (nullable, nonatomic, retain) NSSet<Category *> *categories;
@property (nullable, nonatomic, retain) NSSet<Deal *> *deals;
@property (nullable, nonatomic, retain) NSSet<Image *> *imageURLs;

@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(Category *)value;
- (void)removeCategoriesObject:(Category *)value;
- (void)addCategories:(NSSet<Category *> *)values;
- (void)removeCategories:(NSSet<Category *> *)values;

- (void)addDealsObject:(Deal *)value;
- (void)removeDealsObject:(Deal *)value;
- (void)addDeals:(NSSet<Deal *> *)values;
- (void)removeDeals:(NSSet<Deal *> *)values;

- (void)addImageURLsObject:(Image *)value;
- (void)removeImageURLsObject:(Image *)value;
- (void)addImageURLs:(NSSet<Image *> *)values;
- (void)removeImageURLs:(NSSet<Image *> *)values;

@end

NS_ASSUME_NONNULL_END
