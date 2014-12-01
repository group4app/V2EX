//
//  TopicView.m
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicView.h"
#import "NSDate+General.h"
#import <UIImageView+AFNetworking.h>
#import "UIColor+GL.h"
#import "Topic.h"
#import "Member.h"

@implementation TopicView

- (void)awakeFromNib
{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.avatarView addGestureRecognizer:tap];
}

- (void) handleTap:(id)sender{
    
    if(self.delegate){
        [self.delegate memberSelected:self.topic.member];
    }
}


- (void) setTopic:(Topic *)topic{
    
    _topic = topic;
    
    if([topic.member.avatarNormal rangeOfString:@"http"].location==NSNotFound){
        topic.member.avatarNormal = [NSString stringWithFormat:@"http:%@",topic.member.avatarNormal];
    }
    NSURL *avatarUrl = [NSURL URLWithString:topic.member.avatarNormal];
    [self.avatarView setImageWithURL:avatarUrl];
    self.titleLabel.text = topic.title;
    self.contentLabel.text = topic.content;
    [self.contentLabel markWithSymbol:@"@" Color:[UIColor appMainColor] font:[UIFont systemFontOfSize:15]];
    [self.contentLabel markLinkWithColor:[UIColor appMainColor] font:[UIFont systemFontOfSize:15]];
    
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)topic.replies];
    
    [self.contentLabel showSymbols];
}


- (IBAction)refreshButtonPressed:(id)sender{
    
    if(self.delegate){
        self.refreshButton.hidden = YES;
        [self.activityView startAnimating];
        [self.delegate refreshTopicReplies];
    }
}

@end
