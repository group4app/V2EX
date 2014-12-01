//
//  TopicMemberParser.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicMemberParser.h"
#import "Topic.h"
#import "Member.h"
#import "Node.h"
#import <HTMLReader.h>

@implementation TopicMemberParser


- (NSArray*) topicsFromHtml:(NSString *)html{
    
    HTMLDocument *doc = [HTMLDocument documentWithString:html];
    
    NSString *titleSelector = @"span[class=\"item_title\"]>a";
    NSString *groupSelector = @"span[class=\"small fade\"]>a[class=\"node\"]";
    NSString *replySelector = @"a[class=\"count_livid\"]";
    
    NSMutableArray *topics = [[NSMutableArray alloc] init];
    NSArray *titles = [self contentsFromDocumenet:doc bySelector:titleSelector];
    NSArray *groups = [self contentsFromDocumenet:doc bySelector:groupSelector];
    NSArray *replies = [self contentsFromDocumenet:doc bySelector:replySelector];
    
    NSUInteger minCount = MIN(MIN(titles.count, groups.count),replies.count);
    for(NSUInteger i=0;i<minCount;i++){
        Topic *topic = [[Topic alloc] init];
        topic.title = titles[i];
        topic.replies = [replies[i] integerValue];
        topic.node.name = groups[i];
        [topics addObject:topic];
    }
    
    return topics;
}

@end
