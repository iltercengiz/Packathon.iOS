//
//  FeedItem.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    [mapping addAttributesFromDictionary:@{NSStringFromSelector(@selector(identifier)): @"id",
                                           NSStringFromSelector(@selector(title)): @"title",
                                           NSStringFromSelector(@selector(content)): @"description"}];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:NSStringFromSelector(@selector(createdAt)) keyPath:@"created_at" map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [formatter dateFromString:value];
        }
        return nil;
    } reverseMap:^id(id value) {
        return [formatter stringFromDate:value];
    }];
    [mapping addAttribute:attribute];
    
    return mapping;
}

@end
