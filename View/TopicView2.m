//
//  TopicView2.m
//  V2EX
//
//  Created by Chris Huang on 14-10-27.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TopicView2.h"
#import "SymbolAttributedLabel.h"
#import "Topic.h"
#import "Member.h"
#import <UIImageView+AFNetworking.h>
#import "UIColor+GL.h"
#import "AppClient.h"
#import "UIView+Frame.h"

@implementation TopicView2

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
    if(![topic.member.avatarNormal hasPrefix:@"http"]){
        topic.member.avatarNormal = [NSString stringWithFormat:@"http:%@",topic.member.avatarNormal];
    }
    NSURL *avatarUrl = [NSURL URLWithString:topic.member.avatarNormal];
    [self.avatarView setImageWithURL:avatarUrl];
    self.titleLabel.text = topic.title;
    self.contentLabel.text = topic.content;
    [self.contentLabel markWithSymbol:@"@" Color:[UIColor appMainColor] font:[UIFont systemFontOfSize:15]];
    [self.contentLabel markLinkWithColor:[UIColor appMainColor] font:[UIFont systemFontOfSize:15]];
    self.contentLabel.delegate = self;
    
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)topic.replies];
    
    [self.contentLabel showSymbols];
    [self.activityView startAnimating];
    
}

- (IBAction)refreshButtonPressed:(id)sender{
    
    if(self.delegate){
        [self.activityView startAnimating];
        self.refreshButton.hidden = YES;
        [self.delegate refreshTopicReplies];
    }
    
}

#pragma mark -
#pragma mark === TTAttributeLabelDelegate ===
#pragma mark -
- (void) attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result{
    
    NSLog(@"--- result select ---");
    NSString *linkText = [label.text substringWithRange:result.range];
    NSRange range = result.range;
    if([linkText hasSuffix:@"jpg"]){
        NSString *accept = @"image/jpeg";
        [[AppClient shareInstance] requestWithUrl:linkText accept:accept success:^(id result) {
            UIImage *image = [UIImage imageWithData:result];
            image = [UIImage imageWithCGImage:image.CGImage scale:4.0 orientation:UIImageOrientationUp];
            NSLog(@"image = %@",image);
            
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            attach.image = image;
            NSAttributedString *attributedImage = [NSAttributedString attributedStringWithAttachment:attach];
            NSMutableAttributedString *attributedText = [label.attributedText mutableCopy];
            [attributedText replaceCharactersInRange:range withAttributedString:attributedImage];
            label.attributedText = attributedText;
            label.sizeH = label.sizeH + 100;
            
//            [label setNeedsDisplay];
            
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
        }];
    }
}


@end
