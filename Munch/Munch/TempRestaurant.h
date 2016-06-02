//
//  TempRestaurant.h
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Deal.h"
#import "Image.h"

@interface TempRestaurant : NSObject


@property (nonatomic) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSString *name;
@property (nonatomic) int pricing;
@property (nonatomic) float rating;
@property (nonatomic) NSString *verbalAddress;
@property (nonatomic) NSString *categories;
@property (nonatomic) NSSet<Deal *> *deals;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSNumber *distance;
@property (nonatomic) NSString *ratingURL;

@property (nonatomic) UIImage *image;

- (instancetype)initWithInfo:(NSDictionary *)info;


@end
