//
//  UIColor+GL.m
//  V2EX
//
//  Created by Chris Huang on 14-8-11.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "UIColor+GL.h"

@implementation UIColor (GL)

+ (UIColor*) appMainColor{

    return RGB_COLOR(19, 148, 214);
}

+ (UIColor*) appSubColor{
    
    return RGB_COLOR(142, 200, 74);
}

+ (UIColor*) appMenuBackgroundColor{
    
    return RGB_COLOR(22, 23, 26);
}

+ (UIColor*) appMenuSelectColor{
    
    return RGB_COLOR(44, 45, 48);
}

@end
