//
//  RemoteProcedureProxy.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "RemoteProcedureProxy.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@interface RemoteProcedureProxy ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;
@property (nonatomic) AFHTTPSessionManager *authenticatedSessionManager;
@property (nonatomic) NSString *authenticationToken;
@property (nonatomic, readwrite) User *user;

@end

@implementation RemoteProcedureProxy

@synthesize authenticationToken = _authenticationToken;
@synthesize user = _user;

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static RemoteProcedureProxy *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RemoteProcedureProxy new];
    });
    return sharedInstance;
}

#pragma mark - Getters

- (User *)user {
    NSDictionary *userData = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kPackathonUserKey];
    if (userData) {
        _user = [FEMDeserializer objectFromRepresentation:userData mapping:[User defaultMapping]];
    } else {
        _user = nil;
    }
    return _user;
}

- (BOOL)isLoggedIn {
    _isLoggedIn = (self.authenticationToken != nil);
    return _isLoggedIn;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:kPackathonBaseURL];
    }
    return _sessionManager;
}

- (AFHTTPSessionManager *)authenticatedSessionManager {
    if (!_authenticatedSessionManager) {
        _authenticatedSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:kPackathonBaseURL];
    }
    return _authenticatedSessionManager;
}

- (NSString *)authenticationToken {
    if (!_authenticationToken) {
        _authenticationToken = [UICKeyChainStore stringForKey:kPackathonTokenKey];
        if (_authenticationToken) {
            [self.authenticatedSessionManager.requestSerializer setValue:_authenticationToken forHTTPHeaderField:@"Authorization"];
        }
    }
    return _authenticationToken;
}

#pragma mark - Setters

- (void)setUser:(User *)user {
    if (user) {
        NSDictionary *userData = [FEMSerializer serializeObject:user usingMapping:[User defaultMapping]];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kPackathonUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPackathonUserKey];
    }
    _user = user;
}

- (void)setAuthenticationToken:(NSString *)authenticationToken {
    _authenticationToken = authenticationToken;
    [UICKeyChainStore setString:authenticationToken forKey:kPackathonTokenKey];
    if (authenticationToken) {
        [self.authenticatedSessionManager.requestSerializer setValue:authenticationToken forHTTPHeaderField:@"Authorization"];
    }
}

@end

@implementation RemoteProcedureProxy (EndPoints)

- (NSURLSessionTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSError *error))completion {
    return [self.sessionManager POST:kPackathonAPIEndPointLogin
                          parameters:@{@"username": username, @"password": password}
                            progress:nil
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 NSDictionary *response = (NSDictionary *)responseObject;
                                 self.authenticationToken = [@"Token " stringByAppendingString:response[@"key"]];
                                 if (completion) {
                                     completion(nil);
                                 }
                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 if (completion) {
                                     completion(error);
                                 }
                             }];
}

- (void)logout {
    self.authenticationToken = nil;

}

- (NSURLSessionTask *)userWithCompletion:(void (^)(User *user, NSError *error))completion {
    return [self.sessionManager GET:kPackathonAPIEndPointUser
                         parameters:nil
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                self.user = [FEMDeserializer objectFromRepresentation:responseObject mapping:[User defaultMapping]];
                                if (completion) {
                                    completion(self.user, nil);
                                }
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                if (completion) {
                                    completion(nil, error);
                                }
                            }];
}

- (NSURLSessionTask *)feedsWithCompletion:(void (^)(Feed *feed, NSError *error))completion {
    return [self.sessionManager GET:kPackathonAPIEndPointFeeds
                         parameters:nil
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                Feed *feed = [FEMDeserializer objectFromRepresentation:responseObject mapping:[Feed defaultMapping]];
                                if (completion) {
                                    completion(feed, nil);
                                }
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                if (completion) {
                                    completion(nil, error);
                                }
                            }];
}

- (NSURLSessionTask *)projectsWithCompletion:(void (^)(ProjectList *projectList, NSError *error))completion {
    return [self.sessionManager GET:kPackathonAPIEndPointProjects
                         parameters:nil
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                ProjectList *projectList = [FEMDeserializer objectFromRepresentation:responseObject mapping:[ProjectList defaultMapping]];
                                if (completion) {
                                    completion(projectList, nil);
                                }
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                if (completion) {
                                    completion(nil, error);
                                }
                            }];
}

- (NSURLSessionTask *)voteProject:(Project *)project completion:(void (^)(NSString *message, BOOL status))competion {
    NSString *endPoint = [NSString stringWithFormat:kPackathonAPIEndPointProjectVote, project.identifier];
    return [self.authenticatedSessionManager POST:endPoint
                                       parameters:nil
                                         progress:nil
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              NSDictionary *response = (NSDictionary *)responseObject;
                                              if (competion) {
                                                  competion(response[@"message"], [response[@"status"] boolValue]);
                                              }
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                              NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                                              if (competion) {
                                                  competion(serializedData[@"message"], [serializedData[@"status"] boolValue]);
                                              }
                                          }];
}

@end
