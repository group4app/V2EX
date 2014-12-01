//
//  MemberTopicCell.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberTopicCell.h"
#import "Topic.h"
#import "Node.h"

@implementation MemberTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setTopic:(Topic *)topic{
    
    _topic = topic;
    
    self.titleLabel.text = topic.title;
    self.groupLabel.text = topic.node.name;
    self.replyLabel.text = [NSString stringWithFormat:@"%ld 回复",(long)topic.replies];
}

@end
