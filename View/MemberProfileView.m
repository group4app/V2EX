//
//  MemberProfileView.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberProfileView.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "Member.h"
#import <QuartzCore/QuartzCore.h>

@implementation MemberProfileView

- (void)awakeFromNib {
    
    self.backgroundColor = RGB_COLOR(240, 240, 240);
}


- (void) setMember:(Member *)member{
    
    _member = member;
    if(![self.member.avatarNormal hasPrefix:@"http"]){
        self.member.avatarNormal = [NSString stringWithFormat:@"http:%@",self.member.avatarNormal];
    }
    NSURL *url = [NSURL URLWithString:self.member.avatarNormal];
    [self.avatarView setImageWithURL:url];
    self.avatarView.layer.cornerRadius = 24.0f;
    self.avatarView.layer.masksToBounds = YES;
    
    self.nameLabel.text = self.member.username;
    self.rankLabel.text = self.member.rank;
    self.joinLabel.text = self.member.joinTime;
    
}


@end
