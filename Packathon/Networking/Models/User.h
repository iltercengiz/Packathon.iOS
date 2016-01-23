//
//  User.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descriptionString; // description
@property (nonatomic) NSString *team;
@property (nonatomic) NSString *website;
@property (nonatomic) NSString *git;
@property (nonatomic) NSString *twitter;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *photo;
@property (nonatomic) NSString *url;

+ (FEMMapping *)defaultMapping;

@end
