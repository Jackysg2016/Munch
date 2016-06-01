//
//  FilterView.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "FilterView.h"

@interface FilterView ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *filterTabButton;
@property (weak, nonatomic) IBOutlet UIView *filterScreen;
@property (weak, nonatomic) IBOutlet UIView *dimScreen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterHeightConstraint;

@property (nonatomic) NSDictionary *categoryDict;

@end

@implementation FilterView

//toggle
- (IBAction)pressedFilterTab:(UIButton *)sender {
    
    if(self.filterHeightConstraint.constant == 0.0){
        
        self.filterHeightConstraint.constant = self.frame.size.height * 0.7;
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                               self.dimScreen.alpha = 0.4;
                             
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    
    } else {
        self.filterHeightConstraint.constant = 0.0;
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                              self.dimScreen.alpha = 0.0;
                             
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self layoutIfNeeded];              
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}

//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    TheatreCVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"theatreCell" forIndexPath:indexPath];
//    
//    TheatreObject *thisTheatre = self.theatres[indexPath.row];
//    
//    cell.theatreLabel.text = thisTheatre.name;
//    cell.infoLabel.text = thisTheatre.address;
//    cell.distanceLabel.text = [NSString stringWithFormat:@"%0.1f km",(float)(thisTheatre.distanceFromCurrent/1000)];
//    //NSLog(@"%@",[NSString stringWithFormat:@"%0.2f km",(float)(thisTheatre.distanceFromCurrent/1000)]);
//    
//    return cell;
//
//}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 20;
}

@end
