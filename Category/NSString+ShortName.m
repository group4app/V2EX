//
//  NSString+ShortName.m
//  V2EX
//
//  Created by Chris Huang on 14-8-20.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "NSString+ShortName.h"

@implementation NSString (ShortName)

- (NSString*) trim{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) lowercase{
    
    return [self lowercaseString];
}

- (NSString*) uppercase{
    
    return [self uppercaseString];
}

- (NSString*) converse{
    
    const char *chs = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *string = [[NSMutableString alloc] init];
    for(int i=self.length-1;i>=0;i--){
        [string appendFormat:@"%c",chs[i]];
    }
    
    return string;
}

- (BOOL) isEmpty{
    
    return (self==nil || self.length==0);
}

//search
- (BOOL) containString:(NSString *)string{
    
    NSRange range = [self rangeOfString:string];
    return range.location!=NSNotFound;
}

- (NSUInteger) indexOfString:(NSString *)string{
    
    NSRange range = [self rangeOfString:string];
    return range.location;
}

- (NSUInteger) lastIndexOfString:(NSString *)string{
    
    NSRange range = [self rangeOfString:string options:NSBackwardsSearch];
    return range.location;
}

//replace
- (NSString*) replaceOldString:(NSString *)oldStr withNewString:(NSString *)newStr{
    
    return [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
}

//sub string
- (NSString*) substringFrom:(NSUInteger)from{
    
    return [self substringFromIndex:from];
}

- (NSString*) subStringTo:(NSUInteger)to{
    
    return [self substringToIndex:to];
}

- (NSString*) subStringFrom:(NSUInteger)from to:(NSUInteger)to{
    
    return [self substringWithRange:NSMakeRange(from, to-from)];
}

- (NSArray*) splitWithRegex:(NSString *)regex{
    
    NSError *error;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSMutableArray *segments = [[NSMutableArray alloc] init];
    if(!error){
        NSArray *matches = [regular matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
        NSRange prevRange = NSMakeRange(-1, 0);
        for(NSTextCheckingResult *match in matches){
            
            [segments addObject:[self subStringFrom:prevRange.location+1 to:match.range.location]];
            prevRange = match.range;
        }
        
        [segments addObject:[self substringFrom:prevRange.location+1]];
    }
    
    return segments;
}

- (NSArray*) splitWithCharacterSet:(NSString *)set{
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:set];
    
    return [self componentsSeparatedByCharactersInSet:characterSet];
}

//concat
- (NSString*) concatString:(NSString *)string{
    
    return [NSString stringWithFormat:@"%@%@",self,string];
}

@end
