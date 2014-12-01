//
//  MemberProfileView2.m
//  V2EX
//
//  Created by Chris Huang on 14-10-28.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberProfileView2.h"
#import <UIImageView+AFNetworking.h>

@implementation MemberProfileView2

- (void) setMember:(Member *)member{
    
    _member = member;
    if(![self.member.avatarNormal hasPrefix:@"http"]){
        self.member.avatarNormal = [NSString stringWithFormat:@"http:%@",self.member.avatarNormal];
    }
    NSURL *url = [NSURL URLWithString:self.member.avatarNormal];
    [self.avatarView setImageWithURL:url];
    self.avatarView.layer.cornerRadius = 24.0f;
    self.avatarView.layer.masksToBounds = YES;
    
    self.rankLabel.text = self.member.rank;
    
}

@end
