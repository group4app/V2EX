//
//  MemberParser.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberParser.h"
#import "Member.h"
#import <HTMLReader.h>

@implementation MemberParser

- (Member*) memberFromHtml:(NSString *)html{

    HTMLDocument *doc = [HTMLDocument documentWithString:html];
    NSString *selector = @"div[class=sep10]+span[class=gray]";

    HTMLElement *element = [[doc nodesMatchingSelector:selector] lastObject];
    NSString *content = [element textContent];
    NSArray *array = [content componentsSeparatedByString:@"，"];
    
    Member *member = [[Member alloc] init];
    member.rank = array[0];
    member.joinTime = array[1];
    
    return member;
}

@end
