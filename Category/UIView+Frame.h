//
//  UIView+Frame.h
//  V2EX
//
//  Created by Chris Huang on 14-7-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat sizeW;
@property (nonatomic, assign) CGFloat sizeH;

@end
