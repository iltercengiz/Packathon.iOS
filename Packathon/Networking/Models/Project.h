//
//  Project.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property (nonatomic) NSNumber *identifier; // id
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *git;
@property (nonatomic) NSString *website;
@property (nonatomic) NSString *teamName;
@property (nonatomic) NSNumber *teamIdentifier;

+ (FEMMapping *)defaultMapping;

@end
