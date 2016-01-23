//
//  Feed.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "Feed.h"

@implementation Feed

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(count)): @"count",
                                           NSStringFromSelector(@selector(next)): @"next",
                                           NSStringFromSelector(@selector(previous)): @"previous"}];
    [mapping addToManyRelationshipMapping:[FeedItem defaultMapping] forProperty:NSStringFromSelector(@selector(feedItems)) keyPath:@"results"];
    return mapping;
}

@end
