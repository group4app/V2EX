//
//  SymbolAttributedLabel.m
//  V2EX
//
//  Created by Chris Huang on 14-7-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "SymbolAttributedLabel.h"

@interface SymbolAttributedLabel ()

@property(nonatomic,retain) NSMutableArray *oneSymbolArr;
@property(nonatomic,retain) NSMutableArray *twoSymbolArr;

@property(nonatomic,assign) BOOL           linkEnable;
@property(nonatomic,retain) UIColor        *linkColor;
@property(nonatomic,retain) UIFont         *linkFont;

@property(nonatomic,retain) NSMutableArray *propertyArr;

@end

@implementation SymbolAttributedLabel

static NSString *NSRangeSymbol          = @"NSRangeSymbol";
static NSString *kTextSymbol            = @"symbol";
static NSString *kTextStartSymbol       = @"start";
static NSString *kTextEndSymbol         = @"end";
static NSString *kTextFont              = @"font";
static NSString *kTextColor             = @"color";
static NSString *kTextRanges            = @"range";
static NSString *kTextMatches           = @"matches";

- (void) clearProperties{
    
    self.oneSymbolArr = nil;
    self.twoSymbolArr = nil;
    self.propertyArr = nil;
    
}


- (NSMutableArray*) oneSymbolArr{
    
    if(!_oneSymbolArr){
        _oneSymbolArr = [[NSMutableArray alloc] init];
    }
    return _oneSymbolArr;
}

- (NSMutableArray*) twoSymbolArr{
    
    if(!_twoSymbolArr){
        _twoSymbolArr = [[NSMutableArray alloc] init];
    }
    
    return _twoSymbolArr;
}

- (NSMutableArray*) propertyArr{
    
    if(!_propertyArr){
        _propertyArr = [[NSMutableArray alloc] init];
    }
    
    return _propertyArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) markWithSymbol:(NSString *)symbol Color:(UIColor *)color font:(UIFont *)font{
    
    if(self.text){
        NSDictionary *property = [self propertyFromSymbol:symbol color:color font:font];
        if(property)
            [self.propertyArr addObject:property];
    }
    else{
        [self.oneSymbolArr addObject:@{kTextSymbol:symbol,kTextColor:color,kTextFont:font}];
    }
}

- (void) markWithStartSymbol:(NSString *)startSymbol endSymbol:(NSString *)endSymbol color:(UIColor *)color font:(UIFont *)font{
    
    if(self.text){
        NSDictionary *property = [self propertyFromStartSymbol:startSymbol endSymbol:endSymbol color:color font:font];
        if(property)
            [self.propertyArr addObject:property];
    }
    else{
        [self.twoSymbolArr addObject:@{kTextStartSymbol:startSymbol,kTextEndSymbol:endSymbol,kTextColor:color,kTextFont:font}];
    }
}

- (void) markLinkWithColor:(UIColor *)color font:(UIFont *)font{
    
    if(self.text){
        NSDictionary *property = [self propertyOfLinkWithColor:color font:font];
        if(property)
            [self.propertyArr addObject:property];
    }
    else{
        self.linkEnable = YES;
        self.linkColor = color;
        self.linkFont = font;
    }
}


- (NSDictionary*) propertyFromSymbol:(NSString*)symbol color:(UIColor*)color font:(UIFont*)font{
    
    if(symbol.length!=1){
        NSAssert(NO, @"symbol must be one character");
    }
    NSString *pattern = @"\\w+";
    NSSet *escapeSet = [NSSet setWithObjects:@"*",@"+",@"?",@"(",@")",@"[",@"]",@"{",@"}",@".",@"^",@"$", nil];
    if([escapeSet containsObject:symbol]){
        pattern = [NSString stringWithFormat:@"\\%@%@",symbol,pattern];
    }
    else{
        pattern = [NSString stringWithFormat:@"%@%@",symbol,pattern];
    }
    
    NSArray *matches = [self matchsFromPattern:pattern];
    if(matches.count>0)
        return @{kTextColor:color,kTextFont:font,kTextMatches:matches};
    else
        return nil;
}

- (NSDictionary*) propertyFromStartSymbol:(NSString*)start endSymbol:(NSString*)end color:(UIColor*)color font:(UIFont*)font{
    
    if(start.length!=1||end.length!=1){
        NSAssert(NO,@"symbol must be one character");
    }
    
    NSString *pattern = @".+?";
    NSSet *escapeSet = [NSSet setWithObjects:@"*",@"+",@"?",@"(",@")",@"[",@"]",@"{",@"}",@".",@"^",@"$", nil];
    if([escapeSet containsObject:start]){
        pattern = [NSString stringWithFormat:@"\\%@%@",start,pattern];
    }
    else{
        pattern = [NSString stringWithFormat:@"%@%@",start,pattern];
    }
    
    if([escapeSet containsObject:end]){
        pattern = [NSString stringWithFormat:@"%@\\%@",pattern,end];
    }
    else{
        pattern = [NSString stringWithFormat:@"%@%@",pattern,end];
    }
    
    NSArray *matches = [self matchsFromPattern:pattern];
    if(matches.count>0)
        return @{kTextColor:color,kTextFont:font,kTextMatches:matches};
    else
        return nil;
}

- (NSDictionary*) propertyOfLinkWithColor:(UIColor*)color font:(UIFont*)font{
    
    NSString *pattern = @"http(s)?://([a-zA-z0-9\\-]+\\.){1,4}([a-zA-Z0-9\\-]+)(:\\d+)*((/([a-zA-A0-9\\-_]+/)*)([a-zA-Z0-9\\-_%]+(\\.[a-zA-Z]+)?)?)*(\\?([a-zA-Z0-9_]+=[a-zA-Z0-9\\.%\\+\\-_:/=]+)(&[a-zA-Z0-9_]+=[a-zA-Z0-9\\.%\\+\\-_:/=]+)*)?";
    
//    NSString *ipaddress = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    
    NSArray *matches = [self matchsFromPattern:pattern];
    if(matches.count>0)
        return @{kTextColor:color,kTextFont:font,kTextMatches:matches};
    else
        return nil;
}

- (NSArray*) matchsFromPattern:(NSString*)pattern{
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regular matchesInString:self.text options:NSMatchingReportCompletion range:NSMakeRange(0, [self.text length])];
    
    return matches;
}

- (NSArray*) rangeFromPattern:(NSString*)pattern{
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regular matchesInString:self.text options:NSMatchingReportCompletion range:NSMakeRange(0, [self.text length])];
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    
    for(NSTextCheckingResult *match in matches){
        [ranges addObject:[NSValue valueWithRange:match.range]];
    }
    
    return ranges;
}

- (void) setText:(NSString *)text{
    
    [super setText:text];
    
    for(NSDictionary *dict in self.oneSymbolArr){
        NSDictionary *property = [self propertyFromSymbol:dict[kTextSymbol] color:dict[kTextColor] font:dict[kTextFont]];
        [self.propertyArr addObject:property];
    }
    
    for(NSDictionary *dict in self.twoSymbolArr){
        NSDictionary *property = [self propertyFromStartSymbol:dict[kTextStartSymbol] endSymbol:dict[kTextEndSymbol] color:dict[kTextColor] font:dict[kTextFont]];
        [self.propertyArr addObject:property];
    }
    
    if(self.linkEnable){
        [self.propertyArr addObject:[self propertyOfLinkWithColor:self.linkColor font:self.linkFont]];
    }

}

- (void) showSymbols{
    
    for(NSDictionary *property in self.propertyArr){
        for(NSTextCheckingResult *match in property[kTextMatches]){
            NSDictionary *attr = @{NSFontAttributeName:property[kTextFont],NSForegroundColorAttributeName:property[kTextColor]};
            [self addLinkWithTextCheckingResult:match attributes:attr];
        }
    }
}




@end
