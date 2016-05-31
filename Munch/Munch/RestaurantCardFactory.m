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

// UI Stuff
@property (weak, nonatomic) IBOutlet UIButton *munchNowButton;
@property (weak, nonatomic) IBOutlet UIButton *nopeButton;
@property (weak, nonatomic) IBOutlet UIButton *yukButton;



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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
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
    
    NSArray *array = @[@"1",@"2",@"3",@"4"];
    
    RestaurantCardView *newCard = [[RestaurantCardView alloc] init];
    
    newCard.translatesAutoresizingMaskIntoConstraints = NO;
    
    newCard.overlay.frame = newCard.baseView.frame;
    newCard.titleLabel.text = self.data[index];

    newCard.distanceLabel.text = array[index];
    newCard.cusineLabel.text = self.data[index];
    
    newCard.priceLabel.text = @"$ $ $";
    newCard.imageView.image = [UIImage imageNamed:@"testImage"];
    
    newCard.delegate = self;
    
    
    [self layoutIfNeeded];
    
    // Set up rest of information (images, star ratings etc.)
    
    return newCard;
    
}

-(void)setupConstraintsForCard:(RestaurantCardView*)card {
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:20]];
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
        
        [self setupConstraintsForCard:[self.loadedResturants objectAtIndex:i]];
        
        //[self layoutIfNeeded];
        self.resturantLoadedIndex += 1;
    }
    
    [self layoutIfNeeded];
}

#pragma mark - Button Methods -
- (IBAction)munchNowPressed:(UIButton *)sender {
    RestaurantCardView *cardView = [self.loadedResturants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeRight];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView yesClickAction];
    }];
}
- (IBAction)noPressed:(UIButton *)sender {
    RestaurantCardView *cardView = [self.loadedResturants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeLeft];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView noClickAction];
    }];
}
- (IBAction)yukPressed:(UIButton *)sender {
#warning incomplete
    
    RestaurantCardView *cardView = [self.loadedResturants firstObject];
    
    [cardView yukClickAction];
}

// This is so that when there are no items left we cannot press a button and crash the app
-(void)checkButtons {
    if (self.loadedResturants.count == 0) {
        self.yukButton.enabled = NO;
        self.nopeButton.enabled = NO;
        self.munchNowButton.enabled = NO;
    }
}

#pragma mark - ResturantCardViewDelegate Methods -

#warning incomplete - this is where the action should be set
-(void)swipedRightWithCard:(UIView *)card {
    // Remove the top card
    [self.loadedResturants removeObjectAtIndex:0];
    
    if(self.resturantLoadedIndex < self.resturants.count) {
        // If we have more restaurants to load
        [self.loadedResturants addObject:[self.resturants objectAtIndex:self.resturantLoadedIndex]];
        self.resturantLoadedIndex += 1;
        
        // Add the view and set it up
        [self insertSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 2]];
        [self setupConstraintsForCard:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 1]];
        
        [self layoutIfNeeded];

    }
    
    // Check to see if the buttons should be enabled or not
    [self checkButtons];
    
}

#warning incomplete - this is where the action should be set
-(void)swipedLeftWithCard:(UIView *)card {
    // Remove the top card
    [self.loadedResturants removeObjectAtIndex:0];
    
    if(self.resturantLoadedIndex < self.resturants.count) {
        // If we have more restaurants to load
        [self.loadedResturants addObject:[self.resturants objectAtIndex:self.resturantLoadedIndex]];
        self.resturantLoadedIndex += 1;
        
        // Add the view and set it up
        [self insertSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 2]];
        [self setupConstraintsForCard:[self.loadedResturants objectAtIndex:MAX_BUFFER_SIZE - 1]];
        
        [self layoutIfNeeded];
    }

    // Check to see if the buttons should be enabled or not
    [self checkButtons];
}

@end
