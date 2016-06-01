//
//  FilterView.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "FilterView.h"
#import "CategoryCell.h"

@interface FilterView ()

@property (weak,nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@property (nonatomic) NSArray *categoryArray;

@end

@implementation FilterView

-(void)setUpCategoryArray:(NSArray *)array{

   self.categoryArray = @[@"Chinese",@"Korean",@"Japanese",@"Italian",@"French",@"Fast Food",@"Malaysian",@"Singapore",@"Chinese",@"Korean",@"Japanese",@"Italian",@"French",@"Fast Food",@"Malaysian",@"Singapore",@"Chinese",@"Korean",@"Japanese",@"Italian",@"French",@"Fast Food",@"Malaysian",@"Singapore",@"Chinese",@"Korean",@"Japanese",@"Italian",@"French",@"Fast Food",@"Malaysian",@"Singapore"];
 
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCell" forIndexPath:indexPath];

    cell.label.text = self.categoryArray[indexPath.row];
    
    return cell;

    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.categoryArray count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    CategoryCell *selectedCell = (CategoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(selectedCell.imageView.alpha == 0.5){
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         selectedCell.imageView.alpha = 0.0;
                         selectedCell.imageView.layer.transform = CATransform3DMakeScale(0.8,0.8, 1);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    } else {

        
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             selectedCell.imageView.alpha = 0.5;
                             selectedCell.imageView.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.05
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                 selectedCell.imageView.layer.transform = CATransform3DMakeScale(1,1, 1);
                                              }
                                              completion:^(BOOL finished) {
                                                  //dont run segue
                                              }];
                         }];

    }
}

@end
