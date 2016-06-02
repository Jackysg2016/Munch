//
//  TempRestaurant.m
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "TempRestaurant.h"

@implementation TempRestaurant


- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        self.name = info[@"name"];
        self.address = [info[@"location"][@"address"] firstObject];
        self.latitude = [info[@"location"][@"coordinate"][@"latitude"] doubleValue];
        self.longitude = [info[@"location"][@"coordinate"][@"longitude"] doubleValue];
        self.rating = [info[@"rating"] floatValue];
        self.verbalAddress = info[@"location"][@"cross_streets"];
        
        self.imageURL = info[@"image_url"];
        self.distance = @([info[@"distance"] doubleValue]);
        self.phoneNumber = info[@"display_phone"];
        self.ratingURL = info[@"rating_img_url"];
        
        NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
        
        for (NSArray *cat in info[@"categories"]) {
            [categoryArray addObject:[cat firstObject]];
        }
        self.categories = [categoryArray componentsJoinedByString:@", "];
    }
    return self;
}


@end
