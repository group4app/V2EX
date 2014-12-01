//
//  AppClient.h
//  V2EX
//
//  Created by Chris Huang on 14-7-4.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessResultHandler) (id result);
typedef void (^FailureResultHandler) (NSError *error);

@interface AppClient :NSObject

+ (id) shareInstance;

//inner api request
- (NSOperation*) requestWithMethod:(NSString*)method
                      path:(NSString*)path
                 parameter:(NSDictionary*)parameter
                   success:(SuccessResultHandler)successHandler
                   failure:(FailureResultHandler)failureHandler;


//outer non api get request
- (NSOperation*) requestWithUrl:(NSString*)url
                         accept:(NSString*)accept
                        success:(SuccessResultHandler)successHandler
                        failure:(FailureResultHandler)failureHandler;

@end
