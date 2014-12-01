//
//  Topic.m
//  V2EX
//
//  Created by Chris Huang on 14-10-23.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "Topic.h"
#import "Member.h"
#import "Node.h"

@implementation Topic

+ (JSONKeyMapper*) keyMapper{
    
    JSONKeyMapper *mapper = [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
    return mapper;
    
}


- (id) init{
    
    if(self=[super init]){
        self.member = [[Member alloc] init];
        self.node = [[Node alloc] init];
    }
    return self;
}


@end
