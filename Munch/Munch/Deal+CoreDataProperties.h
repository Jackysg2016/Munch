//
//  Deal+CoreDataProperties.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Deal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *textDescription;
@property (nullable, nonatomic, retain) NSSet<Image *> *imageURLs;

@end

@interface Deal (CoreDataGeneratedAccessors)

- (void)addImageURLsObject:(Image *)value;
- (void)removeImageURLsObject:(Image *)value;
- (void)addImageURLs:(NSSet<Image *> *)values;
- (void)removeImageURLs:(NSSet<Image *> *)values;

@end

NS_ASSUME_NONNULL_END
