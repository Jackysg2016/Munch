//
//  CategoryCell.h
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNCCategory.h"

@interface CategoryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
