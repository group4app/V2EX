//
//  AppData.h
//  V2EX
//
//  Created by Chris Huang on 14-7-4.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppClient.h"

@interface AppData : NSObject

+ (id) shareInstance;

- (void) siteStatusSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) siteInfoSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) allNodesSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) nodeWithId:(NSString*)nodeId success:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) latestTopicsSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) hotTopicsSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) topicsWithUsername:(NSString*)username success:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) topicsWithNodeId:(NSString*)nodeId success:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) repliesWithTopicId:(NSString*)topicId success:(SuccessResultHandler)success failure:(FailureResultHandler)failure;

- (void) memberWithUsername:(NSString*)username success:(SuccessResultHandler)success failure:(FailureResultHandler)failure;


@end
