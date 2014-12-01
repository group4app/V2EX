//
//  NSDate+General.h
//  GLComponent
//
//  Created by huangruxue on 13-9-3.
//  Copyright (c) 2013年 sixclick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (General)

//date
+ (id) dateFromString:(NSString*)dateStr format:(NSString*)format;
+ (id) dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (id) dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;



- (NSInteger) year;
- (NSInteger) month;
- (NSInteger) day;
- (NSInteger) hour;
- (NSInteger) minute;
- (NSInteger) second;

- (NSString*) stringWithFormat:(NSString*)format;
- (NSString*) localStringWithFormat:(NSString*)format;

//special date format
- (NSString*) timeBeforeNow;

@end
