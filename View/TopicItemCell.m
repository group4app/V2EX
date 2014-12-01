//
//  TopicItemCell.m
//  V2EX
//
//  Created by Chris Huang on 14-7-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicItemCell.h"
#import <UIImageView+AFNetworking.h>
#import "NSDate+General.h"
#import "UIColor+GL.h"
#import "Topic.h"
#import "Member.h"
#import "Node.h"

#import <QuartzCore/QuartzCore.h>

@implementation TopicItemCell

- (void)awakeFromNib
{
    self.groupLabel.textColor = [UIColor appMainColor];
    
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
    
    if(![topic.member.avatarNormal hasPrefix:@"http"]){
//    if([topic.member.avatarNormal rangeOfString:@"http"].location==NSNotFound){
        topic.member.avatarNormal = [NSString stringWithFormat:@"http:%@",topic.member.avatarNormal];
    }
    NSURL *avatarUrl = [NSURL URLWithString:topic.member.avatarNormal];
    [self.avatarView setImageWithURL:avatarUrl];
    
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:topic.created];
    self.dateLabel.text = [create stringWithFormat:@"yyyy-MM-dd HH:mm"];
    self.idLabel.text = topic.member.username;
    self.titleLabel.text = topic.title;
    self.groupLabel.text = topic.node.title;
    
    [self.replyButton setTitle:[NSString stringWithFormat:@"%ld",(long)topic.replies] forState:UIControlStateNormal];
    self.replyButton.layer.cornerRadius = 5.0f;
    
}

@end
