//
//  MenuItemCell.h
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIView         *colorView;
@property(nonatomic,weak) IBOutlet UIImageView    *iconView;
@property(nonatomic,weak) IBOutlet UILabel        *nameLabel;

@end
