//
//  UIView+Frame.m
//  V2EX
//
//  Created by Chris Huang on 14-7-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    
    frame.origin = origin;
    
    self.frame = frame;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}
- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    
    frame.origin.x = originX;
    
    self.frame = frame;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}
- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    
    frame.origin.y = originY;
    
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
}

- (CGFloat)sizeW {
    return self.frame.size.width;
}
- (void)setSizeW:(CGFloat)sizeW {
    CGRect frame = self.frame;
    
    frame.size.width = sizeW;
    
    self.frame = frame;
}

- (CGFloat)sizeH {
    return self.frame.size.height;
}
- (void)setSizeH:(CGFloat)sizeH {
    CGRect frame = self.frame;
    
    frame.size.height = sizeH;
    
    self.frame = frame;
}

@end
