//
//  Restaurant+CoreDataProperties.h
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Restaurant.h"

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int64_t pricing;
@property (nonatomic) float rating;
@property (nullable, nonatomic, retain) NSString *verbalAddress;
@property (nullable, nonatomic, retain) NSString *categories;
@property (nullable, nonatomic, retain) NSSet<Deal *> *deals;
@property (nullable, nonatomic, retain) NSSet<Image *> *imageURLs;

@end

@interface Restaurant (CoreDataGeneratedAccessors)

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
