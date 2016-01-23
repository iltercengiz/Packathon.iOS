//
//  ProjectList.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "ProjectList.h"

@implementation ProjectList

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(count)): @"count",
                                           NSStringFromSelector(@selector(next)): @"next",
                                           NSStringFromSelector(@selector(previous)): @"previous"}];
    [mapping addToManyRelationshipMapping:[Project defaultMapping] forProperty:NSStringFromSelector(@selector(projects)) keyPath:@"results"];
    return mapping;
}


@end
