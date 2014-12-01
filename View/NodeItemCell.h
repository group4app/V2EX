//
//  NodeItemCell.h
//  V2EX
//
//  Created by Chris Huang on 14-8-14.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Node;

@interface NodeItemCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel     *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel     *subTitleLabel;

@property(nonatomic,weak) IBOutlet UIButton    *optButton;

@property(nonatomic,strong) Node         *node;

- (IBAction)optButtonPressed:(id)sender;

@end
