//
//  TopicParser.h
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HTMLReader.h>

typedef enum {
    TopicSourceMember,
    TopicSourceHot,
    TopicSourceLatest,
    TopicSourceNode
}TopicSourceType;


@interface TopicParser : NSObject


+ (TopicParser*) parserWithType:(TopicSourceType)type;

- (NSArray*) topicsFromHtml:(NSString*)html;

- (NSArray*) contentsFromDocumenet:(HTMLDocument*)doc bySelector:(NSString*)selector;

@end
