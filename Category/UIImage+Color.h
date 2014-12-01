//
//  UIImage+Color.h
//  V2EX
//
//  Created by Chris Huang on 14-7-9.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

- (UIImage *)imageTintedWithColor:(UIColor *)color;

- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

@end
