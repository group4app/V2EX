//
//  MemberReplyCell.h
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reply;

@interface MemberReplyCell : UITableViewCell

@property(nonatomic,weak) IBOutlet  UILabel         *replyLabel;
@property(nonatomic,weak) IBOutlet  UILabel         *titleLabel;
@property(nonatomic,weak) IBOutlet  UILabel         *nameLabel;
@property(nonatomic,weak) IBOutlet  UIView          *innerView;

@property(nonatomic,strong) Reply       *reply;

@end
