//
//  AppData.m
//  V2EX
//
//  Created by Chris Huang on 14-7-4.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "AppData.h"

#define GET         @"GET"
#define POST        @"POST"
#define PUT         @"PUT"
#define DELETE      @"DELETE"

@implementation AppData

+ (id) shareInstance{
    
    static AppData *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppData alloc] initSingleton];
    });
    
    return instance;
}

- (id) init{
    
    NSAssert(NO, @"Can't create singleton instance");
    return nil;
}

- (id) initSingleton{
    
    self = [super init];
    
    return self;
}


- (void) siteStatusSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:SITE_STATUS_PATH parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void) siteInfoSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
 
    [[AppClient shareInstance] requestWithMethod:GET path:SITE_INFO_PATH parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) allNodesSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:NODES_ALL_PATH parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) nodeWithId:(NSString *)nodeId success:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:NODES_SHOW_PATH(nodeId) parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) latestTopicsSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:TOPICS_LASTES_PATH parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) hotTopicsSuccess:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:TOPICS_HOT_PATH parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) topicsWithUsername:(NSString *)username success:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:TOPICS_SHOW_USERNAME_PATH(username) parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) topicsWithNodeId:(NSString *)nodeId success:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:TOPICS_SHOW_NODE_ID_PATH(nodeId) parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) repliesWithTopicId:(NSString *)topicId success:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:REPLIES_SHOW_PATH(topicId) parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void) memberWithUsername:(NSString *)username success:(SuccessResultHandler)success failure:(FailureResultHandler)failure{
    
    [[AppClient shareInstance] requestWithMethod:GET path:MEMBERS_SHOW_PATH(username) parameter:nil success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
