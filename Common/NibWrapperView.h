//
//  NibWrapperView.h
//  ClearCopy
//
//  Created by Chris Huang on 14-7-3.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NibWrapperView : UIView

@property(nonatomic,strong) NSString *nibName;

@property(nonatomic,strong) id       contentView;

@end
