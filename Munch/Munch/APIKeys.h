//
//  APIKeys.h
//  Munch
//
//  Created by Taylor Benna on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIKeys : NSObject

+(NSString *) getAPIKey;
+(NSString *) getAPIKeySecret;
+(NSString *) getAPIToken;
+(NSString *) getAPISecretToken;

@end
