//
//  RemoteProcedureProxy.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteProcedureProxyDefines.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface RemoteProcedureProxy : NSObject

@property (nonatomic, readonly) User *user;
@property (nonatomic) BOOL isLoggedIn;

+ (instancetype)sharedInstance;

@end

@interface RemoteProcedureProxy (EndPoints)

- (NSURLSessionTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSError *error))completion;
- (void)logout;
- (NSURLSessionTask *)userWithCompletion:(void (^)(User *user, NSError *error))completion;
- (NSURLSessionTask *)feedsWithCompletion:(void (^)(Feed *feed, NSError *error))completion;
- (NSURLSessionTask *)projectsWithCompletion:(void (^)(ProjectList *projectList, NSError *error))completion;
- (NSURLSessionTask *)voteProject:(Project *)project completion:(void (^)(NSString *message, BOOL status))competion;

@end
