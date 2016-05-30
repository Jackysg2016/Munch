//
//  ResturantCardView.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ResturantCardView.h"

@interface ResturantCardView ()

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic) CGFloat xFromCentre;
@property (nonatomic) CGFloat yFromCentre;

@end

@implementation ResturantCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupView];
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(isDragged:)];
        
        
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


#pragma mark - Gesture Recognizer -

-(void)isDragged:(UIPanGestureRecognizer*)sender {
    self.xFromCentre = [sender translationInView:self].x;
    self.yFromCentre = [sender translationInView:self].y;
}

@end
