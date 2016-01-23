//
//  ProjectList.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ProjectList : NSObject

@property (nonatomic) NSNumber *count;
@property (nonatomic) NSString *next;
@property (nonatomic) NSString *previous;
@property (nonatomic) NSArray<Project *> *projects;

+ (FEMMapping *)defaultMapping;

@end
