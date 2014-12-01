//
//  SymbolAttributedLabel.h
//  V2EX
//
//  Created by Chris Huang on 14-7-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface SymbolAttributedLabel : TTTAttributedLabel

- (void) markWithSymbol:(NSString*)symbol Color:(UIColor*)color font:(UIFont*)font;

- (void) markWithStartSymbol:(NSString*)startSymbol endSymbol:(NSString*)endSymbol color:(UIColor*)color font:(UIFont*)font;

- (void) markLinkWithColor:(UIColor*)color font:(UIFont*)font;

- (void) showSymbols;

- (void) clearProperties;

@end
