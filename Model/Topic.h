//
//  Topic.h
//  V2EX
//
//  Created by Chris Huang on 14-10-23.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "TopicParser.h"


@protocol Topic

@end

@class Member;
@class Node;

@interface Topic : JSONModel

@property(nonatomic,assign) NSInteger               identifier;
@property(nonatomic,strong) NSString                *title;
@property(nonatomic,strong) NSString                *url;
@property(nonatomic,strong) NSString                *content;
@property(nonatomic,strong) NSString                *contentRendered;
@property(nonatomic,assign) NSInteger               replies;
@property(nonatomic,strong) Member                  *member;
@property(nonatomic,strong) Node                    *node;
@property(nonatomic,assign) NSInteger               created;
@property(nonatomic,assign) NSInteger               lastModified;
@property(nonatomic,assign) NSInteger               lastTouched;


@end
