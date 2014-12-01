//
//  MenuViewController.h
//  V2EX
//
//  Created by Chris Huang on 14-7-7.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView   *menuView;
@property (nonatomic, strong) IBOutlet UIView        *contentView;
@property (nonatomic, strong) IBOutlet UIView        *gestureView;

@end
