//
//  RestaurantCardView.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "RestaurantCardView.h"
#import "RestaurantCardViewOverlay.h"

#define ACTION_MARGIN 120
#define SCALE_STRENGTH 4
#define SCALE_MAX 0.93
#define ROTATION_MAX 1
#define ROTATION_STRENGTH 320
#define ROTATION_ANGLE (M_PI/8)

@class Restaurant;
@interface RestaurantCardView ()

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

// Values for translation
@property (nonatomic) CGFloat xFromCentre;
@property (nonatomic) CGFloat yFromCentre;
@property (nonatomic) CGPoint originalPoint;

@end

@implementation RestaurantCardView

#pragma mark - UIView Lifecycle etc. -

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}


-(void)setupView {
    
    // Card properties
    self.layer.cornerRadius = 7;
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset = CGSizeMake(0.0f, 6.0f);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor colorWithRed:0.464 green:0.465 blue:0.464 alpha:1].CGColor;
    self.layer.borderWidth = 1.0f;
    
    // Gesture Recognizer
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(isDragged:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    
    // Overlay
    _overlay = [[RestaurantCardViewOverlay alloc] init];
    _overlay.translatesAutoresizingMaskIntoConstraints = NO;
    _overlay.alpha = 0;
    
    // Restaurant Title Label
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:21];
    
    // Cusine Type Label
    _cusineLabel = [[UILabel alloc]init];
    _cusineLabel.textColor = [UIColor blackColor];
    _cusineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _cusineLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:17];
    _cusineLabel.textColor = [UIColor colorWithRed:0.464 green:0.465 blue:0.464 alpha:1];
    
    // Price Label
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _priceLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:17];
    _priceLabel.textColor = [UIColor colorWithRed:0.464 green:0.465 blue:0.464 alpha:1];
    
    // Image View
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // Distance Label
    _distanceLabel = [[UILabel alloc] init];
    _distanceLabel.textColor = [UIColor blackColor];
    _distanceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _distanceLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:15];
    _distanceLabel.textColor = [UIColor colorWithRed:0.464 green:0.465 blue:0.464 alpha:1];
    
    // Add all of the views to the card
    [self addSubview:_titleLabel];
    [self addSubview:_cusineLabel];
    [self addSubview:_priceLabel];
    [self addSubview:_imageView];
    [self addSubview:_distanceLabel];
    
    // Make sure the overlay is last
    [self addSubview:_overlay];
    
    [self setupConstraints];

}

-(void)setupConstraints{
    // Price Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
    
    // Cusine Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cusineLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.priceLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cusineLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
    
    // Title Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.cusineLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
    
    // ImageView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:-8]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.distanceLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    // Distance Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.distanceLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.distanceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0]];
    
    // Overlay
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    
}

-(void)updateOverlay {
    CGFloat overlayStrength;
    
    if (self.xFromCentre > 0) {
        // set the overlay to right mode
        [self.overlay updateMode:RestaurantCardViewOverlayModeRight];
    } else if (self.xFromCentre <= 0) {
        // set the overlay to left mode
        [self.overlay updateMode:RestaurantCardViewOverlayModeLeft];
    }
    // calculate the strength
    overlayStrength = MIN((CGFloat)fabsf((float)self.xFromCentre) / 100, 0.5);
    
    // set the overlay alpha to overlayStrength
    self.overlay.alpha = overlayStrength;
}

// This is where all of the labels and images will be set up
-(void)setupRestaurant:(Restaurant *)restaurant {
#warning incomplete
}

#pragma mark - Gesture Recognizer -

-(void)isDragged:(UIPanGestureRecognizer*)sender {
    self.xFromCentre = [sender translationInView:self].x;
    self.yFromCentre = [sender translationInView:self].y;
    
    // All of the values for the swiping
    CGFloat rotationStrength;
    CGFloat rotationAngle;
    CGFloat scale;
    CGAffineTransform transform;
    CGAffineTransform scaleTransform;
    
    switch (sender.state) {
        // When it begins we keep track of the original center point
        case UIGestureRecognizerStateBegan:
            self.originalPoint = self.center;
            break;
        // When the state has changed we calculate the transform values
        case UIGestureRecognizerStateChanged:
            rotationStrength = MIN(self.xFromCentre / (CGFloat)ROTATION_STRENGTH, (CGFloat)ROTATION_MAX);
            rotationAngle = (CGFloat)ROTATION_ANGLE * rotationStrength;
            scale = MAX((CGFloat)(1-fabsf((float)rotationStrength)) / (CGFloat)SCALE_STRENGTH , (CGFloat)SCALE_MAX);
            self.center = CGPointMake(self.originalPoint.x + self.xFromCentre, self.originalPoint.y + self.yFromCentre);
            transform = CGAffineTransformMakeRotation(rotationAngle);
            scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            self.transform = scaleTransform;
            [self updateOverlay];
            break;
            
        // When it has ended we run our logic in afterSwipeAction
        case UIGestureRecognizerStateEnded:
            [self afterSwipeAction];
            break;
        default:
            break;
    }
}

#pragma mark - Swipe Action Methods - 

-(void)afterSwipeAction {
    if(self.xFromCentre > ACTION_MARGIN) {
        // right action
        [self rightAction];
    } else if (self.xFromCentre < -ACTION_MARGIN) {
        // left action
        [self leftAction];
    } else {
        // if neither we animate back to the original state
        [UIView animateWithDuration:0.3 animations:^{
            self.center = self.originalPoint;
            self.transform = CGAffineTransformMakeRotation(0);
            self.overlay.alpha = 0;
        }];
    }
}

-(void)rightAction {
    // finishPoint is off of the screen to the right
    CGPoint finishPoint = CGPointMake(500, 2 * self.yFromCentre + self.originalPoint.y);
    
    // animate it
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
    } completion:^(BOOL finished) {
        // After the animation completes we remove the view
        [self removeFromSuperview];
        
        // Then we call the delegate to handle what should be done
        [self.delegate swipedRightWithCard:self];
    }];
    
    
}

-(void)leftAction {
    // finishPoint is off of the screen to the left
    CGPoint finishPoint = CGPointMake(-500, 2 * self.yFromCentre + self.originalPoint.y);
    
    // animate it
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
    } completion:^(BOOL finished) {
        // After the animation completes we remove the view
        [self removeFromSuperview];
        
        // Then we call the delegate to handle what should be done
        [self.delegate swipedLeftWithCard:self];
    }];
    
    
}

#pragma mark actions for when the buttons are clicked rather than swipe

-(void)yesClickAction {
    // When a button is pressed rather than swiping we animate it
    // and then remove it.
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
        self.transform = CGAffineTransformMakeRotation(1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        // We do not need to call the delegate because the event will be
        // already handled.
    }];
}

-(void)noClickAction {
    // When a button is pressed rather than swiping we animate it
    // and then remove it.
    CGPoint finishPoint =  CGPointMake(-600, self.center.y);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
        self.transform = CGAffineTransformMakeRotation(-1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        // We do not need to call the delegate because the event will be
        // already handled.
    }];
}

-(void)yukClickAction {
    [self removeFromSuperview];
}

/* 
 
 * Just incase we use them up and down actions are ready
 
 */

#pragma mark extra methods for up and down that could be used

-(void)upAction {
    CGPoint finishPoint = CGPointMake(2 * self.xFromCentre + self.originalPoint.x, -200);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [self.delegate swipedUpWithCard:self];
}

-(void)downAction {
    CGPoint finishPoint = CGPointMake(2 * self.xFromCentre + self.originalPoint.x, 900);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [self.delegate swipedDownWithCard:self];
}

@end
