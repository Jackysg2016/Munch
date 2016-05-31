//
//  ResturantCardFactory.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "RestaurantCardFactory.h"
#import "RestaurantCardView.h"
#import "RestaurantCardViewOverlay.h"


#define CARD_WIDTH      300
#define CARD_HEIGHT     300
#define MAX_BUFFER_SIZE 3

@interface RestaurantCardFactory () <RestaurantCardViewDelegate>

@property (nonatomic) NSMutableArray *resturants;
@property (nonatomic) NSMutableArray *loadedResturants;
@property (nonatomic) NSArray *data;

@property (nonatomic) NSInteger resturantLoadedIndex;
@property (nonatomic) CGFloat verticalOffset;
@end

@implementation RestaurantCardFactory

#pragma mark - UIView Lifecycle etc. -
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        _resturants = [NSMutableArray array];
        _loadedResturants = [NSMutableArray array];
        _verticalOffset = 0;
        
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

-(RestaurantCardView*)createResturantCardAtIndex:(NSInteger)index {
    
    CGFloat leftBuffer = (self.frame.size.width - CARD_WIDTH) / 2;
    
    RestaurantCardView *newCard = [[RestaurantCardView alloc] initWithFrame:(CGRect){leftBuffer,50, CARD_WIDTH, CARD_HEIGHT}];
    
//    NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"ResturantCardView" owner:self options:nil];
//    ResturantCardView *newCard = [xib objectAtIndex:0];
//
    
    newCard.titleLabel.text = self.data[index];
    [newCard.titleLabel sizeToFit];
    newCard.delegate = self;
    
    // Set up rest of information (images, star ratings etc.)
    
    return newCard;
    
}

-(void)refreshData {
    
    // Get rid of the now outdated views
    for (RestaurantCardView *view in self.loadedResturants) {
        [view removeFromSuperview];
    }
    
    [self.loadedResturants removeAllObjects];
    [self.resturants removeAllObjects];
    
    self.resturantLoadedIndex = 0;
    
    [self loadResturantCards];
    
}


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
        RestaurantCardView *newCard = [self createResturantCardAtIndex:i];
        
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
    RestaurantCardView *cardView = [self.loadedResturants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeRight];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView yesClickAction];
    }];
    
}

-(void)noPressed {
    RestaurantCardView *cardView = [self.loadedResturants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeLeft];
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
