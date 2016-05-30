//
//  ResturantCardViewOverlay.h
//  Munch
//
//  Created by Zach Smoroden on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ResturauntCardViewOverlayMode) {
    ResturauntCardViewOverlayModeLeft,
    ResturauntCardViewOverlayModeRight
};

@interface ResturantCardViewOverlay : UIView

@property (nonatomic) ResturauntCardViewOverlayMode mode;

-(void)updateMode:(ResturauntCardViewOverlayMode)mode;

@end
