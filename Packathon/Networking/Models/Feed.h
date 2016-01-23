//
//  Feed.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface Feed : NSObject

@property (nonatomic) NSNumber *count;
@property (nonatomic) NSString *next;
@property (nonatomic) NSString *previous;
@property (nonatomic) NSArray<FeedItem *> *feedItems;

+ (FEMMapping *)defaultMapping;

@end
