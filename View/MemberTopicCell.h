//
//  MemberTopicCell.h
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;

@interface MemberTopicCell : UITableViewCell

@property(nonatomic,weak) IBOutlet  UILabel         *titleLabel;
@property(nonatomic,weak) IBOutlet  UILabel         *groupLabel;
@property(nonatomic,weak) IBOutlet  UILabel         *replyLabel;

@property(nonatomic,strong) Topic         *topic;

@end
