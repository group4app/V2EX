//
//  TopicItemCell.h
//  V2EX
//
//  Created by Chris Huang on 14-7-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;
@class Member;

@protocol TopicItemCellDelegate <NSObject>

- (void) memberSelected:(Member*)member;

@end

@interface TopicItemCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView             *avatarView;
@property(nonatomic,weak) IBOutlet UILabel                 *idLabel;
@property(nonatomic,weak) IBOutlet UILabel                 *dateLabel;
@property(nonatomic,weak) IBOutlet UILabel                 *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel                 *groupLabel;

@property(nonatomic,weak) IBOutlet UIButton                *replyButton;

@property(nonatomic,strong) Topic                       *topic;
@property(nonatomic,weak) id<TopicItemCellDelegate>     delegate;

@end
