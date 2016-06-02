//
//  FilterView.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "FilterView.h"
#import "CategoryCell.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "MNCCategory.h"
#import "Filter.h"
#import "UserSettings.h"

@interface FilterView ()

@property (weak,nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) Filter *thisFilter;

@end

@implementation FilterView

-(void)setUpCategoryArray:(NSArray *)array{

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Category"];
    
    NSError *error;
    self.categoryArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserSettings"];
    UserSettings *tempUser = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] firstObject];
    
    self.thisFilter = tempUser.lastFilter;
 
}

-(void)awakeFromNib {
    self.categoryCollectionView.allowsMultipleSelection = YES;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCell" forIndexPath:indexPath];

    MNCCategory *currentCat = self.categoryArray[indexPath.row];
    
    cell.imageView.alpha = 0.0;
    
    cell.label.text = currentCat.name;
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.categoryArray count];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCell *selectedCell = (CategoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         selectedCell.imageView.alpha = 0.0;
                         selectedCell.imageView.layer.transform = CATransform3DMakeScale(0.8,0.8, 1);
                     }
                     completion:^(BOOL finished) {}];
    
    [self.thisFilter removePickedCategoriesObject:self.categoryArray[indexPath.row]];

    NSError *error;
    [self.managedObjectContext save:&error];
    NSLog(@"%@",error);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    CategoryCell *selectedCell = (CategoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
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
    
    [self.thisFilter addPickedCategoriesObject:self.categoryArray[indexPath.row]];
    NSError *error;
    [self.managedObjectContext save:&error];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MNCCategory *currentCategory = self.categoryArray[indexPath.row];
    CategoryCell *currentCell = (CategoryCell *)cell;
    
    if ([self.thisFilter.pickedCategories containsObject:currentCategory]) {
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        currentCell.imageView.alpha = 0.5;
    } else {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        currentCell.imageView.alpha = 0.0;
    }
}

@end
