//
//  RestaurantCardFactory.h
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantCardView.h"
#import "TempRestaurant.h"

@protocol RestaurantCardFactoryDataSource <NSObject>

-(void)getMoreRestaurants;
-(void)performSegueToDetailView;
-(void)receivedRestaurant:(TempRestaurant *)tempRestaurant;
-(void)justShowDetails;

@end

@interface RestaurantCardFactory : UIView

@property (nonatomic) NSArray *data;
@property (nonatomic) id<RestaurantCardFactoryDataSource> delegate;

-(void)loadRestaurantCardsWithData:(NSArray*)data;
-(void)resetCardsWithData:(NSArray *)data;


@end
