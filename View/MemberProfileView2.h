//
//  MemberProfileView2.h
//  V2EX
//
//  Created by Chris Huang on 14-10-28.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface MemberProfileView2 : UIView

@property(nonatomic,weak) IBOutlet  UIImageView         *avatarView;
@property(nonatomic,weak) IBOutlet  UILabel             *rankLabel;

@property(nonatomic,strong) Member      *member;

@end
