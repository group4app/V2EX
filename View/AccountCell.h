//
//  AccountCell.h
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIButton        *avatarButton;
@property(nonatomic,weak) IBOutlet UIButton        *loginButton;
@property(nonatomic,weak) IBOutlet UILabel         *nameLabel;

@end
