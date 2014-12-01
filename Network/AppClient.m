//
//  AppClient.m
//  V2EX
//
//  Created by Chris Huang on 14-7-4.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "AppClient.h"
#import <AFNetworking.h>

@implementation AppClient

- (id) init{
    
    NSAssert(NO,@"Can't create instance of singleton");
    return nil;
}

- (id) initSingleton{
    
    self = [super init];
    return self;
}

+ (id) shareInstance{
    
    static AppClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppClient alloc] initSingleton];
    });
    
    
    return instance;
}

- (NSOperation*) requestWithMethod:(NSString *)method
                      path:(NSString *)path
                 parameter:(NSDictionary *)parameter
                   success:(SuccessResultHandler)successHandler
                   failure:(FailureResultHandler)failureHandler{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",V2EX_HOST,path];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlString parameters:parameter error:NULL];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureHandler(error);
    }];
    
    [manager.operationQueue addOperation:operation];
    
    return operation;
}


//get request
- (NSOperation*) requestWithUrl:(NSString*)url
                         accept:(NSString*)accept
                        success:(SuccessResultHandler)successHandler
                        failure:(FailureResultHandler)failureHandler{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:accept, nil];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:nil error:NULL];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureHandler(error);
    }];
    
    [manager.operationQueue addOperation:operation];
    
    return operation;
}


@end
