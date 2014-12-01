//
//  MemberProfileView.h
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Member;

@interface MemberProfileView : UITableViewCell

@property(nonatomic,weak) IBOutlet  UIImageView         *avatarView;
@property(nonatomic,weak) IBOutlet  UILabel             *nameLabel;
@property(nonatomic,weak) IBOutlet  UILabel             *rankLabel;
@property(nonatomic,weak) IBOutlet  UILabel             *joinLabel;


@property(nonatomic,strong) Member      *member;


@end
