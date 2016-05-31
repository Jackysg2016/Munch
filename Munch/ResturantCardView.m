//
//  ResturantCardView.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ResturantCardView.h"
#import "ResturantCardViewOverlay.h"

#define ACTION_MARGIN 120
#define SCALE_STRENGTH 4
#define SCALE_MAX 0.93
#define ROTATION_MAX 1
#define ROTATION_STRENGTH 320
#define ROTATION_ANGLE (M_PI/8)

@interface ResturantCardView ()

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;





// Values for translation
@property (nonatomic) CGFloat xFromCentre;
@property (nonatomic) CGFloat yFromCentre;
@property (nonatomic) CGPoint originalPoint;

@end

@implementation ResturantCardView

#pragma mark - UIView Lifecycle etc. -

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupView];
        
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    
    return self;
}


-(void)setupView {
    
    // Card properties
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.backgroundColor = [UIColor whiteColor];
    
    // Gesture Recognizer
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(isDragged:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    
    // Overlay
    _overlay = [[ResturantCardViewOverlay alloc] initWithFrame:self.bounds];
    _overlay.alpha = 0;
    [self addSubview:_overlay];
    
    // Resturant Title Label
    
    // WithFrame:CGRectMake(0, self.frame.size.height - 30, 20, 30)
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Cusine Type Label
    _cusineLabel = [[UILabel alloc]init];
    _cusineLabel.textColor = [UIColor blackColor];
    _cusineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _cusineLabel.text = @"mexican";
    
    // Price Label
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _priceLabel.text = @"$$$";
    
    [self addSubview:_titleLabel];
    [self addSubview:_cusineLabel];
    [self addSubview:_priceLabel];
    
    [self setupConstraints];

}

-(void)setupConstraints {
    
    // Price Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:0]];

    
    // Cusine Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cusineLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cusineLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.priceLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    // Title Label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.cusineLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:0]];
    
}

-(void)updateOverlay {
    CGFloat overlayStrength;
    
    if (self.xFromCentre > 0) {
        // set the overlay to right mode
        [self.overlay updateMode:ResturauntCardViewOverlayModeRight];
    } else if (self.xFromCentre <= 0) {
        // set the overlay to left mode
        [self.overlay updateMode:ResturauntCardViewOverlayModeLeft];
    }
    overlayStrength = MIN((CGFloat)fabsf((float)self.xFromCentre) / 100, 0.5);
    
    // set the overlay alpha to overlayStrength
    self.overlay.alpha = overlayStrength;
    
}

#pragma mark - Gesture Recognizer -

-(void)isDragged:(UIPanGestureRecognizer*)sender {
    self.xFromCentre = [sender translationInView:self].x;
    self.yFromCentre = [sender translationInView:self].y;
    
    CGFloat rotationStrength;
    CGFloat rotationAngle;
    CGFloat scale;
    CGAffineTransform transform;
    CGAffineTransform scaleTransform;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.originalPoint = self.center;
            break;
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
    CGPoint finishPoint = CGPointMake(500, 2 * self.yFromCentre + self.originalPoint.y);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [self.delegate swipedRightWithCard:self];
}

-(void)leftAction {
    CGPoint finishPoint = CGPointMake(-500, 2 * self.yFromCentre + self.originalPoint.y);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [self.delegate swipedLeftWithCard:self];
}

#pragma mark actions for when the buttons are clicked rather than swipe

-(void)yesClickAction {
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
        self.transform = CGAffineTransformMakeRotation(1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)noClickAction {
    CGPoint finishPoint =  CGPointMake(-600, self.center.y);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = finishPoint;
        self.transform = CGAffineTransformMakeRotation(-1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)yuckClickAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
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
