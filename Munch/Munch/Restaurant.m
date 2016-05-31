//
//  Restaurant.m
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//

#import "Restaurant.h"
#import "Category.h"
#import "Deal.h"
#import "Image.h"

@implementation Restaurant

-(void) addInfoFromDictionary:(NSDictionary *)info {
    self.name = info[@"name"];
    self.address = [info[@"location"][@"address"] firstObject];
    self.latitude = [info[@"location"][@"coordinate"][@"latitude"] doubleValue];
    self.longitude = [info[@"location"][@"coordinate"][@"longitude"] doubleValue];
    self.rating = [info[@"rating"] floatValue];
    self.verbalAddress = info[@"location"][@"cross_streets"];
    
    for (NSString *cat in info[@"categories"]) {
        
        Category *cate = [[Category alloc] init];
        cate.name = cat;
        
        [self addCategoriesObject:cate];
    }
}

-(NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)info {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if(self) {
        
        self.name = info[@"name"];
        self.address = [info[@"location"][@"address"] firstObject];
        self.latitude = [info[@"location"][@"coordinate"][@"latitude"] doubleValue];
        self.longitude = [info[@"location"][@"coordinate"][@"longitude"] doubleValue];
        self.rating = [info[@"rating"] floatValue];
        self.verbalAddress = info[@"location"][@"cross_streets"];
        
        for (NSArray *cat in info[@"categories"]) {
            
            Category *cate = [[Category alloc] initWithEntity:[NSEntityDescription entityForName:@"Category" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
            cate.name = [cat firstObject];

            [self addCategoriesObject:cate];
        }
        
        Image *img = [[Image alloc] initWithEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        img.imageURL = info[@"image_url"];

        [self addImageURLsObject:img];
        
    }
    return self;
}

@end