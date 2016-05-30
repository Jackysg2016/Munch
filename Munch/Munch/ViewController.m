//
//  ViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "ViewController.h"
#import "ResturantCardFactory.h"

@interface ViewController ()

@property (nonatomic) ResturantCardFactory *factory;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _factory = [[ResturantCardFactory alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:_factory];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
