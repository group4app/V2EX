//
//  NSDate+General.m
//  GLComponent
//
//  Created by huangruxue on 13-9-3.
//  Copyright (c) 2013年 sixclick. All rights reserved.
//

#import "NSDate+General.h"

#define SECOND  1
#define MINUTE  60
#define HOUR    (MINUTE*60)
#define DAY     (HOUR*24)
#define WEEK    (DAY*7)
#define MONTH   (DAY*30)
#define YEAR    (DAY*365)

@implementation NSDate (General)

+ (id) dateFromString:(NSString *)dateStr format:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    
    return [formatter dateFromString:dateStr];
}

+ (id) dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:[NSDate date]];
    component.year = year;
    component.month = month;
    component.day = day;
    
    return [calendar dateFromComponents:component];
}

+ (id) dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:[NSDate date]];
    component.year = year;
    component.month = month;
    component.day = day;
    component.hour = hour;
    component.minute = minute;
    component.second = second;
    
    return [calendar dateFromComponents:component];
}

- (NSInteger) year{
    
    return [self component].year;

}

- (NSInteger) month{
    
    return [self component].month;

}

- (NSInteger) day{
    
    return [self component].day;

}

- (NSInteger) hour{
    
    return [self component].hour;
}

- (NSInteger) minute{
    
    return [self component].minute;

}

- (NSInteger) second{
    
    return [self component].second;
}

- (NSString*) stringWithFormat:(NSString *)format{
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:locale];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    
    return [formatter stringFromDate:self];
}

- (NSString*) localStringWithFormat:(NSString*)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    formatter.locale = [NSLocale currentLocale];
    
    NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMT];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:seconds];
    
    return [formatter stringFromDate:self];
}

- (NSDateComponents*) component{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *component = [calendar components:unitFlags fromDate:self];
    
    return component;
}

- (NSString*) timeBeforeNow{
    
    NSInteger delta = fabs([self timeIntervalSinceNow]);
    NSString *suffix = @"前";
    NSArray *unitsDes = @[@"年",@"月",@"周",@"天",@"小时",@"分钟",@"秒"];
    NSArray *units = @[@YEAR,@MONTH,@WEEK,@DAY,@HOUR,@MINUTE,@SECOND];
    NSInteger unitIndex = 0;
    
    NSInteger unit = [units[unitIndex] integerValue];
    while (delta/unit<1) {
        unit = [units[++unitIndex] integerValue];
    }
    
    return [NSString stringWithFormat:@"%d %@%@",delta/unit,unitsDes[unitIndex],suffix];
}

@end
