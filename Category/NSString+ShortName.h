//
//  NSString+ShortName.h
//  V2EX
//
//  Created by Chris Huang on 14-8-20.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ShortName)

- (NSString*) trim;
- (NSString*) lowercase;
- (NSString*) uppercase;
- (NSString*) converse;

- (BOOL) isEmpty;  // string == nil || string.length == 0

//search
- (BOOL) containString:(NSString*)aString;
- (NSUInteger) indexOfString:(NSString*)string;
- (NSUInteger) lastIndexOfString:(NSString*)string;

//replace
- (NSString*) replaceOldString:(NSString*)oldStr withNewString:(NSString*)newStr;

//sub string
- (NSString*) substringFrom:(NSUInteger)from;
- (NSString*) subStringTo:(NSUInteger)to;
- (NSString*) subStringFrom:(NSUInteger)from to:(NSUInteger)to;   //[from,to)

//split
- (NSArray*) splitWithRegex:(NSString*)regex;
- (NSArray*) splitWithCharacterSet:(NSString*)set;

//concat
- (NSString*) concatString:(NSString*)string;

@end
