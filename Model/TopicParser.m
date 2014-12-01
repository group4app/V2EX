//
//  TopicParser.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicParser.h"
#import "TopicMemberParser.h"

@implementation TopicParser

+ (TopicParser*) parserWithType:(TopicSourceType)type{
    
    TopicParser *parser;
    if(type==TopicSourceMember){
        parser = [[TopicMemberParser alloc] init];
    }
    
    return parser;
}


- (NSArray*) contentsFromDocumenet:(HTMLDocument*)doc bySelector:(NSString*)selector{
    
    NSArray *nodes = [doc nodesMatchingSelector:selector];
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    for(HTMLNode *node in nodes){
        [contents addObject:[node textContent]];
    }
    
    return contents;
}

@end
