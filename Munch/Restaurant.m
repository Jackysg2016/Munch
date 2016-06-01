//
//  Restaurant.m
//  Munch
//
//  Created by Taylor Benna on 2016-06-01.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "Restaurant.h"
#import "Deal.h"
#import "Image.h"
#import "MNCCategory.h"

@implementation Restaurant

-(NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context andDictionary:(NSDictionary *)info {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if(self) {
        
        self.name = info[@"name"];
        self.address = [info[@"location"][@"address"] firstObject];
        self.latitude = @([info[@"location"][@"coordinate"][@"latitude"] doubleValue]);
        self.longitude = @([info[@"location"][@"coordinate"][@"longitude"] doubleValue]);
        self.rating = @([info[@"rating"] floatValue]);
        self.verbalAddress = info[@"location"][@"cross_streets"];
        
        for (NSArray *cat in info[@"categories"]) {
            
            MNCCategory *cate = [[MNCCategory alloc] initWithEntity:[NSEntityDescription entityForName:@"Category" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
            cate.name = [cat firstObject];
            cate.searchString = cat[1];
            
            [self addCategoriesObject:cate];
        }
        
        Image *img = [[Image alloc] initWithEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        img.imageURL = info[@"image_url"];
        
        [self addImageURLsObject:img];
        
    }
    return self;
}


@end
