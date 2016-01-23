//
//  RemoteProcedureProxyDefines.h
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#ifndef RemoteProcedureProxyDefines_h
#define RemoteProcedureProxyDefines_h

#define kPackathonBaseURL [NSURL URLWithString:@"https://packathon.pyninjas.com/"]
#define kPackathonTokenKey @"packathonToken"
#define kPackathonUserKey @"packathonUser"

#define kPackathonAPIEndPointLogin          @"/api/login/"
#define kPackathonAPIEndPointUser           @"/api/user/"
#define kPackathonAPIEndPointFeeds          @"/api/feeds/"
#define kPackathonAPIEndPointProjects       @"/api/projects/"
#define kPackathonAPIEndPointProjectVote    @"/api/projects/%@/vote/"

#import "Feed.h"
#import "FeedItem.h"
#import "User.h"
#import "ProjectList.h"
#import "Project.h"

#endif /* RemoteProcedureProxyDefines_h */
