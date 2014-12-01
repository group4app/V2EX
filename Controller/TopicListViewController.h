//
//  TopicListViewController.h
//  V2EX
//
//  Created by Chris Huang on 14-7-30.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "TopicItemCell.h"

typedef enum{
    TopicReferHot,
    TopicReferLatest,
    TopicReferAllNodes,
    TopicReferBookmark
}TopicReferType;

@interface TopicListViewController : BaseTableViewController<TopicItemCellDelegate>

@property(nonatomic,assign) TopicReferType topicRefer;
@property(nonatomic,strong) NSString       *nodeId;

@end
