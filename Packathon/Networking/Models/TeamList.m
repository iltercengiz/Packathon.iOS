//
//  TeamList.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "TeamList.h"

@implementation TeamList

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(count)): @"count",
                                           NSStringFromSelector(@selector(next)): @"next",
                                           NSStringFromSelector(@selector(previous)): @"previous"}];
    [mapping addToManyRelationshipMapping:[FeedItem defaultMapping] forProperty:NSStringFromSelector(@selector(teams)) keyPath:@"results"];
    return mapping;
}

@end
