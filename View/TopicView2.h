//
//  TopicView2.h
//  V2EX
//
//  Created by Chris Huang on 14-10-27.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymbolAttributedLabel.h"

//@class SymbolAttributedLabel;
@class Topic;
@class Member;

@protocol TopicView2Delegate <NSObject>

- (void) refreshTopicReplies;

- (void) memberSelected:(Member*)member;

@end

@interface TopicView2 : UIView<TTTAttributedLabelDelegate>

@property(nonatomic,weak) IBOutlet UIImageView                *avatarView;
@property(nonatomic,weak) IBOutlet UILabel                    *titleLabel;
@property(nonatomic,weak) IBOutlet SymbolAttributedLabel      *contentLabel;

@property(nonatomic,weak) IBOutlet UILabel                    *commentLabel;
@property(nonatomic,weak) IBOutlet UIButton                   *refreshButton;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView    *activityView;

@property(nonatomic,strong) Topic                           *topic;
@property(nonatomic,weak) id<TopicView2Delegate>            delegate;

@end
