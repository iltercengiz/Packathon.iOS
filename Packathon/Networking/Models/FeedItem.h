//
//  FeedItem.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property (nonatomic) NSNumber *identifier; // id
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *content; // description
@property (nonatomic) NSDate *createdAt; // created_at

+ (FEMMapping *)defaultMapping;

@end
