//
//  Reply.h
//  V2EX
//
//  Created by Chris Huang on 14-10-23.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@protocol Reply

@end

@class Member;

@interface Reply : JSONModel

@property(nonatomic,assign) NSInteger           identifier;
@property(nonatomic,assign) NSInteger           thanks;
@property(nonatomic,strong) NSString            *content;
@property(nonatomic,strong) NSString            *contentRendered;
@property(nonatomic,strong) Member              *member;
@property(nonatomic,assign) NSInteger           created;
@property(nonatomic,assign) NSInteger           lastModified;

//from website
@property(nonatomic,assign) NSInteger           topicId;
@property(nonatomic,strong) NSString<Optional>  *topicAuthor;
@property(nonatomic,strong) NSString<Optional>  *topicTitle;

@end
