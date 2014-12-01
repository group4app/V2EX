//
//  Group.m
//  V2EX
//
//  Created by Chris Huang on 14-10-30.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "Group.h"

@implementation Group

+ (JSONKeyMapper*) keyMapper{
    
    JSONKeyMapper *mapper = [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
    return mapper;
    
}

@end
