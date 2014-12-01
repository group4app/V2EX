//
//  CommentItemCell.m
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "CommentItemCell.h"
#import "NSDate+General.h"
#import <UIImageView+AFNetworking.h>
#import "UIView+Frame.h"
#import "UIColor+GL.h"

#import "Reply.h"
#import "Member.h"

@implementation CommentItemCell

- (void)awakeFromNib
{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.avatarView addGestureRecognizer:tap];
}

- (void) handleTap:(id)sender{
    
    if(self.delegate){
        [self.delegate memberSelected:self.comment.member];
    }
}

- (void) setComment:(Reply *)comment{
    
    _comment = comment;
    
    if(![comment.member.avatarNormal hasPrefix:@"http"]){
//    if([comment.member.avatarNormal rangeOfString:@"http"].location==NSNotFound){
        comment.member.avatarNormal = [NSString stringWithFormat:@"http:%@",comment.member.avatarNormal];
    }
    NSURL *avatarUrl = [NSURL URLWithString:comment.member.avatarNormal];
    [self.avatarView setImageWithURL:avatarUrl];
    
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:comment.created];
    self.dateLabel.text = [create timeBeforeNow];
    self.nameLabel.text = comment.member.username;
    self.contentLabel.text = comment.content;
    [self.contentLabel markWithSymbol:@"@" Color:[UIColor appMainColor] font:[UIFont systemFontOfSize:15]];
    [self.contentLabel markLinkWithColor:[UIColor appMainColor] font:[UIFont systemFontOfSize:15]];
 
    [self.contentLabel showSymbols];
}


@end
