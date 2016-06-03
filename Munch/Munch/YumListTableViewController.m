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

@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation YumListTableViewController

-(void)viewDidLoad {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSError *error;
    [self.managedObjectContext save:&error];
    
    self.restaurants = [[NSMutableArray alloc] init];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    NSArray *tempRes = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (int i = (int)tempRes.count - 1; i >= 0; i--) {
        [self.restaurants addObject:tempRes[i]];
    }
    
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
