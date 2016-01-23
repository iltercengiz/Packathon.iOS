//
//  Project.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "Project.h"

@implementation Project

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(identifier)): @"id",
                                           NSStringFromSelector(@selector(name)): @"name",
                                           NSStringFromSelector(@selector(git)): @"git",
                                           NSStringFromSelector(@selector(website)): @"website",
                                           NSStringFromSelector(@selector(teamName)): @"team.name",
                                           NSStringFromSelector(@selector(teamIdentifier)): @"team.id"}];
    return mapping;
}

@end
