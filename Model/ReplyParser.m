//
//  ReplyParser.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "ReplyParser.h"
#import <HTMLReader.h>

#import "Reply.h"

@implementation ReplyParser

- (NSArray*) repliesFromHtml:(NSString *)html{
    
    HTMLDocument *doc = [HTMLDocument documentWithString:html];
    
    NSString *topicIdSelector = @"div[class=dock_area] a";
    NSString *topicAuthorSelector = @"div[class=fr]+span[class=gray]";
    NSString *topicTitleSelector = @"div[class=dock_area] a";
    NSString *replySelector = @"div[class]>div[class=reply_content]";
    NSString *name = @"href";
    
    NSArray *topicIds = [self attributesFromDocument:doc bySelector:topicIdSelector attributeName:name];
    NSArray *topicAuthors = [self contentsFromDocument:doc bySelector:topicAuthorSelector];
    NSArray *topicTitles = [self contentsFromDocument:doc bySelector:topicTitleSelector];
    NSArray *contents = [self contentsFromDocument:doc bySelector:replySelector];
    
    NSUInteger minCount = MIN(MIN(MIN(topicIds.count, topicAuthors.count),topicTitles.count),contents.count);
    NSMutableArray *replies = [[NSMutableArray alloc] init];
    for(NSUInteger i=0;i<minCount;i++){
        Reply *reply = [[Reply alloc] init];
        NSString *path = topicIds[i];
        NSString *topicId = [[[[path componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"#"] firstObject];
        reply.topicId = [topicId integerValue];
        NSString *author = topicAuthors[i];
        reply.topicAuthor = [author componentsSeparatedByString:@" "][1];
        reply.topicTitle = topicTitles[i];
        reply.content = contents[i];
        
        [replies addObject:reply];
    }
    
    return replies;
}

- (NSArray*) contentsFromDocument:(HTMLDocument*)doc bySelector:(NSString*)selector{
    
    NSArray *nodes = [doc nodesMatchingSelector:selector];
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    for(HTMLNode *node in nodes){
        [contents addObject:[node textContent]];
    }
    
    return contents;
}

- (NSArray*) attributesFromDocument:(HTMLDocument*)doc bySelector:(NSString*)selector attributeName:(NSString*)name{
    
    NSArray *nodes = [doc nodesMatchingSelector:selector];
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    for(HTMLElement *element in nodes){
        
        [attributes addObject:[element attributes][name]];
    }

    return attributes;
}

@end
