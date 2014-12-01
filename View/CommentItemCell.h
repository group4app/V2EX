//
//  CommentItemCell.h
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymbolAttributedLabel.h"

@class Reply;
@class Member;

@protocol CommentItemCellDelegate <NSObject>

- (void) memberSelected:(Member*)member;

@end

@interface CommentItemCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView                *avatarView;
@property(nonatomic,weak) IBOutlet UILabel                    *dateLabel;
@property(nonatomic,weak) IBOutlet UILabel                    *nameLabel;
@property(nonatomic,weak) IBOutlet SymbolAttributedLabel      *contentLabel;

@property(nonatomic,strong) Reply                       *comment;
@property(nonatomic,weak) id<CommentItemCellDelegate>   delegate;


@end
