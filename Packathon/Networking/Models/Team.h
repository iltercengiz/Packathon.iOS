//
//  Team.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Project.h"

@interface Team : NSObject

@property (nonatomic) NSNumber *identifier; // id
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *projectURL;
@property (nonatomic) NSArray<User *> *users;

+ (FEMMapping *)defaultMapping;

@end
