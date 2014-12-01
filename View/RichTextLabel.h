//
//  RichTextLabel.h
//  V2EX
//
//  Created by Chris Huang on 14-8-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RichTextLabel : UILabel

- (void) addLinkWithTextCheckingResult:(NSTextCheckingResult*)result;

- (void) addLinkWithTextCheckingResult:(NSTextCheckingResult*)result attributes:(NSDictionary*)attributes;

- (void) addLinkWithTextCheckingResults:(NSArray*)results attributes:(NSDictionary*)attributes;

@end
