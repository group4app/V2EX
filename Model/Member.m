//
//  Member.m
//  V2EX
//
//  Created by Chris Huang on 14-10-23.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "Member.h"

@implementation Member

+ (JSONKeyMapper*) keyMapper{
    
    JSONKeyMapper *mapper = [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
    return mapper;
    
}

+ (BOOL) propertyIsOptional:(NSString *)propertyName{
    
    if([propertyName isEqualToString:@"created"])
        return YES;
    return NO;
    
}

@end
