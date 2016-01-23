//
//  Team.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "Team.h"

@implementation Team

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(identifier)): @"id",
                                           NSStringFromSelector(@selector(name)): @"name",
                                           NSStringFromSelector(@selector(projectURL)): @"project"}];
    [mapping addToManyRelationshipMapping:[User defaultMapping] forProperty:NSStringFromSelector(@selector(users)) keyPath:@"users"];
    return mapping;
}

@end
