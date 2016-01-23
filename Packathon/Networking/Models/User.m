//
//  User.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "User.h"

@implementation User

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(username)): @"username",
                                           NSStringFromSelector(@selector(name)): @"name",
                                           NSStringFromSelector(@selector(descriptionString)): @"description",
                                           NSStringFromSelector(@selector(team)): @"team",
                                           NSStringFromSelector(@selector(website)): @"website",
                                           NSStringFromSelector(@selector(git)): @"git",
                                           NSStringFromSelector(@selector(twitter)): @"twitter",
                                           NSStringFromSelector(@selector(email)): @"email",
                                           NSStringFromSelector(@selector(photo)): @"photo",
                                           NSStringFromSelector(@selector(url)): @"url"}];
    return mapping;
}

@end
