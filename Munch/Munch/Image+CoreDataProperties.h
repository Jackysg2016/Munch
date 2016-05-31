//
//  Image+CoreDataProperties.h
//  
//
//  Created by Enoch Ng on 2016-05-30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Image.h"

NS_ASSUME_NONNULL_BEGIN

@interface Image (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
