//
//  MemberReplyCell.m
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberReplyCell.h"
#import "Reply.h"
#import <QuartzCore/QuartzCore.h>

@implementation MemberReplyCell

- (void)awakeFromNib {
    
    self.innerView.backgroundColor = RGB_COLOR(240, 240, 240);
    self.innerView.layer.cornerRadius = 3.0f;
}

- (void) setReply:(Reply *)reply{
    
    _reply = reply;
    
    self.replyLabel.text = reply.content;
    self.titleLabel.text = reply.topicTitle;
    self.nameLabel.text = [@"by " stringByAppendingString:reply.topicAuthor];
    
}

@end
