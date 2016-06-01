//
//  RestaurantCardFactory.m
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "RestaurantCardFactory.h"
#import "RestaurantCardView.h"
#import "RestaurantCardViewOverlay.h"
#import "Restaurant.h"
#import "Image.h"
#import "MNCCategory.h"


#define CARD_WIDTH      300
#define CARD_HEIGHT     300
#define MAX_BUFFER_SIZE 3

@interface RestaurantCardFactory () <RestaurantCardViewDelegate>

@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) NSMutableArray *loadedRestaurants;


@property (nonatomic) NSInteger restaurantLoadedIndex;
@property (nonatomic) CGFloat verticalOffset;

// UI Stuff
@property (weak, nonatomic) IBOutlet UIButton *munchNowButton;
@property (weak, nonatomic) IBOutlet UIButton *nopeButton;
@property (weak, nonatomic) IBOutlet UIButton *yukButton;

@property (nonatomic) float buttonShrinkRatio;

@end

@implementation RestaurantCardFactory

#pragma mark - UIView Lifecycle etc. -

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _restaurants = [NSMutableArray array];
        _loadedRestaurants = [NSMutableArray array];
        _verticalOffset = 0;
        self.buttonShrinkRatio = 0.8;
    }
    return self;
}

#pragma mark - Card Creation -

-(RestaurantCardView*)createRestaurantCardAtIndex:(NSInteger)index {
    
    RestaurantCardView *newCard = [[RestaurantCardView alloc] init];
    
    Restaurant *restaurant = self.data[index];
    
    newCard.translatesAutoresizingMaskIntoConstraints = NO;
    
    newCard.overlay.frame = newCard.baseView.frame;
    newCard.titleLabel.text = restaurant.name;

    newCard.distanceLabel.text = restaurant.verbalAddress;
    
    
    // This needs to be changed to grab a category or something
    // MNCCategory *category = [restaurant.categories anyObject];
    
    NSMutableArray *allCategoryNames = [NSMutableArray array];
    
    for (MNCCategory *cat in [restaurant.categories allObjects]) {
        [allCategoryNames addObject:cat.name];
    }
    
    NSString *categoryString = [allCategoryNames componentsJoinedByString:@", "];
    
    newCard.cusineLabel.text = categoryString;
    
    newCard.priceLabel.text = [NSString stringWithFormat:@"Rating: %@", restaurant.rating ];
    
    Image *img = [restaurant.imageURLs anyObject];
    [self downloadImageForCard:newCard withURLString:img.imageURL];
    
    newCard.imageView.image = [UIImage imageNamed:@"testImage"];
    
    newCard.delegate = self;
    
    
    [self layoutIfNeeded];
    
    
    return newCard;
    
}

-(void)downloadImageForCard:(RestaurantCardView*)card withURLString:urlString{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    card.imageView.image = image;
                });
            }
        }
    }];
    [task resume];
    
}

-(void)setupConstraintsForCard:(RestaurantCardView*)card {
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:card attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:20]];
}

// This may come in handy later so keep it here
//-(void)refreshData {
//    
//    // Get rid of the now outdated views
//    for (RestaurantCardView *view in self.loadedRestaurants) {
//        [view removeFromSuperview];
//    }
//    
//    [self.loadedRestaurants removeAllObjects];
//    [self.restaurants removeAllObjects];
//    
//    self.restaurantLoadedIndex = 0;
//    
//    [self loadRestaurantCards];
//    
//}


-(void)loadRestaurantCardsWithData:(NSArray*)data {
    // Actual Data
    self.data = data;
    
    // If we have less than the buffer size of restaurants left we don't want to try to load 3
    NSInteger numLoadedCardsCap;
    if (self.data.count > 0) {
        numLoadedCardsCap = MAX_BUFFER_SIZE;
    } else {
        numLoadedCardsCap = self.data.count;
    }
    
    // For all of the data we got (restaurants to show) create a restaurant object and if applicable
    // add it to the loaded buffer
    for (int i = 0; i < self.data.count; i++) {
        RestaurantCardView *newCard = [self createRestaurantCardAtIndex:i];
        
        [self.restaurants addObject:newCard];
        
        if (i < numLoadedCardsCap) {
            [self.loadedRestaurants addObject:newCard];
        }
        
    }
    
    // Now we load the views onto the screen
    for (int i = 0; i < self.loadedRestaurants.count; i++) {
        
        if (i > 0) {
            [self insertSubview:[self.loadedRestaurants objectAtIndex:i] belowSubview:[self.loadedRestaurants objectAtIndex:i - 1]];
        } else {
            [self addSubview:[self.loadedRestaurants objectAtIndex:i]];
        }
        
        [self setupConstraintsForCard:[self.loadedRestaurants objectAtIndex:i]];
        
        //[self layoutIfNeeded];
        self.restaurantLoadedIndex += 1;
    }
    
    [self layoutIfNeeded];
}

#pragma mark - Button Methods -
- (void)munchNowPressed:(UIButton *)sender {

    RestaurantCardView *cardView = [self.loadedRestaurants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeRight];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView yesClickAction];
    }];
    
}
- (void)noPressed:(UIButton *)sender {
    
    RestaurantCardView *cardView = [self.loadedRestaurants firstObject];
    [self swipedRightWithCard:cardView];
    
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeLeft];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView noClickAction];
    }];
    
    
}
- (void)yukPressed:(UIButton *)sender {
#warning incomplete
    RestaurantCardView *cardView = [self.loadedRestaurants firstObject];
    [self swipedDownWithCard:cardView];
    [cardView.overlay updateMode:RestaurantCardViewOverlayModeLeft];
    [UIView animateWithDuration:0.2 animations:^{
        cardView.overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [cardView yukClickAction];
    }];

}


-(IBAction)holdDown:(UIButton*) sender{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(self.buttonShrinkRatio,self.buttonShrinkRatio, 1);
                     }
                     completion:^(BOOL finished) {
                     }];
}

-(IBAction)holdRelease:(UIButton *) sender{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.05
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              
                                              sender.layer.transform = CATransform3DMakeScale(1,1, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              // Tag 1: Munch button
                                              // Tag 2: Nope Button
                                              // Tag 3: Yuk Button
                                              if(sender.tag == 1){
                                                  [self munchNowPressed:sender];
                                              } else if (sender.tag == 2) {
                                                  [self noPressed:sender];
                                              } else if (sender.tag == 3) {
                                                  [self yukPressed:sender];
                                              }
                                          }];
                     }];
}

-(IBAction)holdReleaseOutside:(UIButton *)sender{
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sender.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.05
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              sender.layer.transform = CATransform3DMakeScale(1,1, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              //dont run segue
                                          }];
                     }];
}
// This is so that when there are no items left we cannot press a button and crash the app
-(void)checkButtons {
    if (self.loadedRestaurants.count == 0) {
        self.yukButton.enabled = NO;
        self.nopeButton.enabled = NO;
        self.munchNowButton.enabled = NO;
    }
}

#pragma mark - RestaurantCardViewDelegate Methods -

#warning incomplete - this is where the action should be set
-(void)swipedRightWithCard:(UIView *)card {
    // Remove the top card
    [self.loadedRestaurants removeObjectAtIndex:0];
    
    if(self.restaurantLoadedIndex < self.restaurants.count) {
        // If we have more restaurants to load
        [self.loadedRestaurants addObject:[self.restaurants objectAtIndex:self.restaurantLoadedIndex]];
        self.restaurantLoadedIndex += 1;
        
        // Add the view and set it up
        [self insertSubview:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 2]];
        [self setupConstraintsForCard:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 1]];
        
        [self layoutIfNeeded];

    }
    
    // Check to see if the buttons should be enabled or not
    [self checkButtons];
    
}

#warning incomplete - this is where the action should be set
-(void)swipedLeftWithCard:(UIView *)card {
    // Remove the top card
    [self.loadedRestaurants removeObjectAtIndex:0];
    
    if(self.restaurantLoadedIndex < self.restaurants.count) {
        // If we have more restaurants to load
        [self.loadedRestaurants addObject:[self.restaurants objectAtIndex:self.restaurantLoadedIndex]];
        self.restaurantLoadedIndex += 1;
        
        // Add the view and set it up
        [self insertSubview:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 2]];
        [self setupConstraintsForCard:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 1]];
        
        [self layoutIfNeeded];
    }

    // Check to see if the buttons should be enabled or not
    [self checkButtons];
}

-(void)swipedDownWithCard:(UIView *)card {
    // Remove the top card
    [self.loadedRestaurants removeObjectAtIndex:0];
    
    if(self.restaurantLoadedIndex < self.restaurants.count) {
        // If we have more restaurants to load
        [self.loadedRestaurants addObject:[self.restaurants objectAtIndex:self.restaurantLoadedIndex]];
        self.restaurantLoadedIndex += 1;
        
        // Add the view and set it up
        [self insertSubview:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 1] belowSubview:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 2]];
        [self setupConstraintsForCard:[self.loadedRestaurants objectAtIndex:MAX_BUFFER_SIZE - 1]];
        
        [self layoutIfNeeded];
    }
    
    // Check to see if the buttons should be enabled or not
    [self checkButtons];

}

@end
