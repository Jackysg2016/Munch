//
//  ResturantCardFactory.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ResturantCardFactory.h"
#import "ResturantCardView.h"
#import "ResturantCardViewOverlay.h"


#define CARD_WIDTH      290
#define CARD_HEIGHT     290
#define MAX_BUFFER_SIZE 3

@interface ResturantCardFactory () <ResturantCardViewDelegate>

@property (nonatomic) NSMutableArray *resturants;
@property (nonatomic) NSMutableArray *loadedResturants;
@property (nonatomic) NSArray *data;

@property (nonatomic) NSInteger resturantLoadedIndex;

@end

@implementation ResturantCardFactory

#pragma mark - UIView Lifecycle etc. -
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        _resturants = [NSMutableArray array];
        _loadedResturants = [NSMutableArray array];
        
        [self loadResturantCards];
    }
    return self;
}

-(void)setupView {
    self.layer.borderWidth = 1;
    self.backgroundColor = [UIColor clearColor];
    
    // Set up buttons maybe here
}

#pragma mark - Card Creation -

-(ResturantCardView*)createResturantCardAtIndex:(NSInteger)index {
    
    CGRect rect = CGRectMake((CGFloat)(self.frame.size.width - CARD_WIDTH / 2), self.frame.size.height - CARD_WIDTH / 2, (CGFloat)CARD_WIDTH, (CGFloat)CARD_HEIGHT);
    
    
    ResturantCardView *newCard = [[ResturantCardView alloc] initWithFrame:(CGRect){CARD_WIDTH / 4,CARD_WIDTH / 2,CARD_WIDTH,CARD_HEIGHT}];
    newCard.label.text = self.data[index];
    newCard.delegate = self;
    
    // Set up rest of information (images, star ratings etc.)
    
    return newCard;
    
}

-(void)refreshData {
    
    // Get rid of the now outdated views
    for (ResturantCardView *view in self.loadedResturants) {
        [view removeFromSuperview];
    }
    
    [self.loadedResturants removeAllObjects];
    [self.resturants removeAllObjects];
    
    self.resturantLoadedIndex = 0;
    
    [self loadResturantCards];
    
}

#warning not implemented
-(void)loadResturantCards {
    // Some sample data
    self.data = @[@"Subway",@"Noodlebox",@"La Taqueria",@"Meat & Bread"];
    
    // If we have less than the buffer size of resturants left we don't want to try to load 3
    NSInteger numLoadedCardsCap;
    if (self.data.count > 0) {
        numLoadedCardsCap = MAX_BUFFER_SIZE;
    } else {
        numLoadedCardsCap = self.data.count;
    }
    
    // For all of the data we got (resturants to show) create a resturant object and if applicable
    // add it to the loaded buffer
    for (int i = 0; i < self.data.count; i++) {
        ResturantCardView *newCard = [self createResturantCardAtIndex:i];
        
        [self.resturants addObject:newCard];
        
        if (i < numLoadedCardsCap) {
            [self.loadedResturants addObject:newCard];
        }
        
    }
    
    // Now we load the views onto the screen
    for (int i = 0; i < self.loadedResturants.count; i++) {
        if (i > 0) {
            [self insertSubview:[self.loadedResturants objectAtIndex:i] belowSubview:[self.loadedResturants objectAtIndex:i - 1]];
        } else {
            [self addSubview:[self.loadedResturants objectAtIndex:i]];
        }
        self.resturantLoadedIndex += 1;
    }
    
    
}

#pragma mark - Button Methods -

-(void)yesPressed {
    ResturantCardView *cardView = [self.loadedResturants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:ResturauntCardViewOverlayModeRight];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView yesClickAction];
    }];
    
}

-(void)noPressed {
    ResturantCardView *cardView = [self.loadedResturants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:ResturauntCardViewOverlayModeLeft];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView noClickAction];
    }];
}
#pragma mark - ResturantCardViewDelegate Methods -

-(void)swipedRightWithCard:(UIView *)card {
    [self.loadedResturants removeObjectAtIndex:0];
    
    if(self.resturantLoadedIndex < self.resturants.count) {
        [self.loadedResturants addObject:[self.resturants objectAtIndex:self.resturantLoadedIndex]];
        self.resturantLoadedIndex += 1;
        
        [self insertSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 2]];
    }
    
}

-(void)swipedLeftWithCard:(UIView *)card {
    [self.loadedResturants removeObjectAtIndex:0];
    
    if(self.resturantLoadedIndex < self.resturants.count) {
        [self.loadedResturants addObject:[self.resturants objectAtIndex:self.resturantLoadedIndex]];
        self.resturantLoadedIndex += 1;
        
        [self insertSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 2]];
    }

}

@end
