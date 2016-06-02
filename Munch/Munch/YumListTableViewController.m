//
//  YumListTableViewController.m
//  
//
//  Created by Taylor Benna on 2016-06-02.
//
//

#import "YumListTableViewController.h"
#import "RestaurantCell.h"
#import "Restaurant.h"
#import "AppDelegate.h"

@interface YumListTableViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSArray *restaurants;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation YumListTableViewController

-(void)viewDidLoad {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    self.restaurants = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restaurantCell"];
    Restaurant *currentRes = self.restaurants[indexPath.row];
    
    cell.nameLabel.text = currentRes.name;
    cell.categoryLabel.text = currentRes.categories;
    
    return cell;
}

@end
