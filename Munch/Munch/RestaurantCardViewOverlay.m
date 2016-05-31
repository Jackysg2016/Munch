//
//  ResturantCardViewOverlay.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "RestaurantCardViewOverlay.h"

@interface RestaurantCardViewOverlay ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation RestaurantCardViewOverlay

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"x"]];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.imageView];
        
        [self setupConstraints];
        //[self layoutIfNeeded];
        
        
    }
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    
//    if(self) {
//        self.backgroundColor = [UIColor whiteColor];
//        
//        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"x"]];
//        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
//        [self addSubview:self.imageView];
//        
//        [self setupConstraints];
//        [self layoutIfNeeded];
//        
//        
//    }
//    
//    return self;
//}

-(void)setupConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
}

-(void)updateMode:(RestaurantCardViewOverlayMode)mode {
    if(self.mode == mode) {
        return;
    }
    
    self.mode = mode;
    
    if(mode == RestaurantCardViewOverlayModeLeft) {
        self.imageView.image = [UIImage imageNamed:@"x"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"check"];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(50, 50, 100, 100);
    self.imageView.center = CGPointMake(self.bounds.size.height/2, self.bounds.size.width/2);
}

@end
