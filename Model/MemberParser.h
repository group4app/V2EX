//
//  MemberParser.h
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member;

@interface MemberParser : NSObject

- (Member*) memberFromHtml:(NSString*)html;

@end
