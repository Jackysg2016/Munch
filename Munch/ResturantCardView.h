//
//  ResturantCardView.h
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResturantCardViewDelegate <NSObject>

-(void)swipedLeftWithCard:(UIView*)card;
-(void)swipedRightWithCard:(UIView*)card;

@optional
-(void)swipedUpWithCard:(UIView*)card;
-(void)swipedDownWithCard:(UIView*)card;

@end

@interface ResturantCardView : UIView

@property (nonatomic) id<ResturantCardViewDelegate> delegate;


@end
