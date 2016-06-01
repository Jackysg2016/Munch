//
//  RestaurantCardFactory.h
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantCardFactory : UIView

@property (nonatomic) NSArray *data;

-(void)loadRestaurantCardsWithData:(NSArray*)data;

@end
