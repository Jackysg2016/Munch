//
//  YelpClient.m
//  Munch
//
//  Created by Taylor Benna on 2016-05-30.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "YelpClient.h"
#import <AFNetworking/AFJSONRequestOperation.h>
#import "APIKeys.h"


@implementation YelpClient

static NSString *kYelpAPIURLString = @"http://api.yelp.com/v2";


- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kYelpAPIURLString] key:[APIKeys getAPIKey] secret:[APIKeys getAPIKeySecret]];
    if (self) {
        self.accessToken = [[AFOAuth1Token alloc] initWithKey:[APIKeys getAPIToken]
                                                       secret:[APIKeys getAPISecretToken]
                                                      session:nil
                                                   expiration:[NSDate distantFuture]
                                                    renewable:NO];
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

@end