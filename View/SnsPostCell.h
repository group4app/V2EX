//
//  SnsWallCell.h
//  V2EX
//
//  Created by Chris Huang on 14-8-5.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymbolAttributedLabel.h"
#import "SnsPhotoCellDelegate.h"

@interface SnsPostCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UIImageView            *avatarView;
@property(nonatomic,retain) IBOutlet UILabel                *nameLabel;
@property(nonatomic,retain) IBOutlet UILabel                *dateLabel;
@property(nonatomic,retain) IBOutlet SymbolAttributedLabel  *contentLabel;
@property(nonatomic,retain) IBOutlet UIView                 *containerView;

@property(nonatomic,retain) NSDictionary *topic;
@property(nonatomic,weak)   id<SnsPhotoCellDelegate> delegate;

@property(nonatomic,assign) CGFloat                         actualCellHeight;

@end
