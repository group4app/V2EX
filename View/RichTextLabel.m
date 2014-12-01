//
//  RichTextLabel.m
//  V2EX
//
//  Created by Chris Huang on 14-8-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "RichTextLabel.h"
#import <CoreText/CoreText.h>

@interface RichTextLabel ()

@property(nonatomic,strong) id                  ctFrame;
@property(nonatomic,strong) NSMutableArray      *images;

@property(nonatomic,strong) NSDictionary        *linkAttributes;
@property(nonatomic,strong) NSMutableArray      *links;

@end

@implementation RichTextLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //draw frame
    CTFrameDraw((CTFrameRef)self.ctFrame, context);
    
    //draw images
    for(NSDictionary *dict in self.images){
        UIImage *image = dict[@"image"];
        CGRect imageFrame = [dict[@"frame"] CGRectValue];
        CGContextDrawImage(context, imageFrame, image.CGImage);
    }
}

- (void) addLinkWithTextCheckingResult:(NSTextCheckingResult *)result{
    
    [self addLinkWithTextCheckingResult:result attributes:self.linkAttributes];
}

- (void) addLinkWithTextCheckingResult:(NSTextCheckingResult *)result attributes:(NSDictionary *)attributes{
    
    [self addLinkWithTextCheckingResults:@[result] attributes:attributes];
    
}

- (void) addLinkWithTextCheckingResults:(NSArray *)results attributes:(NSDictionary *)attributes{
    
    NSMutableArray *mutableLinks = [self.links mutableCopy];
    if(attributes){
        NSMutableAttributedString *attrString = [self.attributedText mutableCopy];
        for(NSTextCheckingResult *result in results){
            [attrString addAttributes:attributes range:result.range];
        }
        
        self.attributedText = attrString;
    }
    
    [mutableLinks addObjectsFromArray:results];
    [self setNeedsDisplay];
    
    self.links = mutableLinks;
}


@end
