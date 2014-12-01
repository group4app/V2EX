//
//  SnsRetweetedView.h
//  V2EX
//
//  Created by Chris Huang on 14-8-6.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnsPhotoCellDelegate.h"

@interface SnsRetweetedView : UIView

@property(nonatomic,retain) IBOutlet UILabel        *contentLabel;
@property(nonatomic,retain) IBOutlet UIView         *containerView;

@property(nonatomic,retain) NSDictionary    *topic;

@property(nonatomic,weak) id<SnsPhotoCellDelegate> delegate;



@end
