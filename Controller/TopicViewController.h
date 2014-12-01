//
//  TopicViewController.h
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel.h>
#import "TopicView2.h"
#import "CommentItemCell.h"

@class Topic;

@interface TopicViewController : UITableViewController<TTTAttributedLabelDelegate,TopicView2Delegate,CommentItemCellDelegate>

@property(nonatomic,strong) Topic     *topic;

@end
