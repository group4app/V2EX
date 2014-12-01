//
//  UIView+Xib.m
//  ClearCopy
//
//  Created by Chris Huang on 14-7-2.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "UIView+Xib.h"

@implementation UIView (Xib)


+ (UIView*) viewFromXib{
    
    UIView *result = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner: nil options: nil];
    for (id anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            result = anObject;
            break;
        }
    }
    return result;
}

@end
