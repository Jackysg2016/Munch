//
//  ResturantCardView.h
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResturantCardViewOverlay;

@protocol ResturantCardViewDelegate <NSObject>

-(void)swipedLeftWithCard:(UIView*)card;
-(void)swipedRightWithCard:(UIView*)card;

@optional
-(void)swipedUpWithCard:(UIView*)card;
-(void)swipedDownWithCard:(UIView*)card;

@end

@interface ResturantCardView : UIView

@property (nonatomic) id<ResturantCardViewDelegate> delegate;
@property (nonatomic) ResturantCardViewOverlay *overlay;

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *cusineLabel;
@property (nonatomic) UILabel *priceLabel;
@property (nonatomic) UILabel *distanceLabel;
@property (nonatomic) UIImageView *imageView;


-(void)yesClickAction;
-(void)noClickAction;

-(void)setupView;

@end
