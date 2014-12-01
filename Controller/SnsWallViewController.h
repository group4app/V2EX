//
//  SnsWallViewController.h
//  V2EX
//
//  Created by Chris Huang on 14-8-5.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnsPostCell.h"
#import "SnsRetweetedView.h"
#import "SnsPhotoCellDelegate.h"
#import <MWPhotoBrowser.h>

@interface SnsWallViewController : UITableViewController<SnsPhotoCellDelegate,MWPhotoBrowserDelegate>

@end
