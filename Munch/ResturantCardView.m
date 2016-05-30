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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UIView Lifecycle etc. -

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupView];
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(isDragged:)];
        
        _overlay = [[ResturantCardViewOverlay alloc] initWithFrame:self.bounds];
        _overlay.alpha = 0;
        [self addSubview:_overlay];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 200)];
        _label.text = @"testing";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        
        [self addSubview:_label];
        
    }
    
    return self;
}


-(void)setupView {
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.backgroundColor = [UIColor whiteColor];
}

-(void)updateOverlay {
    CGFloat overlayStrength;
    
    if (self.xFromCentre > 0) {
        // set the overlay to right mode
        self.overlay.mode = ResturauntCardViewOverlayModeRight;
    } else if (self.xFromCentre <= 0) {
        // set the overlay to left mode
        self.overlay.mode = ResturauntCardViewOverlayModeLeft;
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
            // max(CGFloat(1-fabsf(Float(rotationStrength))) / CGFloat(SCALE_STRENGTH), CGFloat(SCALE_MAX))
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
