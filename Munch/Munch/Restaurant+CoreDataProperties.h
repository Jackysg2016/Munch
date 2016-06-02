//
//  Restaurant+CoreDataProperties.h
//  Munch
//
//  Created by Taylor Benna on 2016-06-02.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Restaurant.h"

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *categories;
@property (nonatomic) double distance;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nonatomic) int64_t pricing;
@property (nonatomic) float rating;
@property (nullable, nonatomic, retain) NSString *ratingURL;
@property (nullable, nonatomic, retain) NSString *verbalAddress;
@property (nullable, nonatomic, retain) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
