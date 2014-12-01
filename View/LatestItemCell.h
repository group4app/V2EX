//
//  LatestItemCell.h
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestItemCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UIImageView             *avatarView;
@property(nonatomic,strong) IBOutlet UILabel                 *idLabel;
@property(nonatomic,strong) IBOutlet UILabel                 *dateLabel;
@property(nonatomic,strong) IBOutlet UILabel                 *titleLabel;
@property(nonatomic,strong) IBOutlet UILabel                 *groupLabel;

@property(nonatomic,strong) NSDictionary                     *topic;

@end
