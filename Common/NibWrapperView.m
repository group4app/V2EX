//
//  NibWrapperView.m
//  ClearCopy
//
//  Created by Chris Huang on 14-7-3.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "NibWrapperView.h"
#import "UIView+Xib.h"

@implementation NibWrapperView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib{
    
    [super awakeFromNib];
    
    Class viewClass = NSClassFromString(self.nibName);
    UIView *view = [viewClass viewFromXib];
    if(view){
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addSubview:view];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        [self setNeedsLayout];
    }
    
}

- (id) contentView{
    
    return self.subviews.firstObject;
}

@end
