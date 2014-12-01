//
//  NSString+Html.m
//  V2EX
//
//  Created by Chris Huang on 14-8-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "NSString+Html.h"

@implementation NSString (Html)

- (NSString*) htmlContent{

    HTMLDocument *doc = [HTMLDocument documentWithString:self];
    HTMLElement *root = [doc rootElement];
    
    return [root textContent];
}


@end
