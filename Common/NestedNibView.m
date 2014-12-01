//
//  NestedNibView.m
//  ClearCopy
//
//  Created by Chris Huang on 14-7-3.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "NestedNibView.h"
#import "UIView+Xib.h"

@implementation NestedNibView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) awakeAfterUsingCoder:(NSCoder*)aDecoder {
    BOOL placeholder = ([[self subviews] count] == 0);
    if (placeholder) {
        UIView* nibView = [[self class] viewFromXib];
		
        // pass properties through
        nibView.frame = self.frame;
        nibView.autoresizingMask = self.autoresizingMask;
        nibView.alpha = self.alpha;
        nibView.hidden = self.hidden;
		
        return nibView;
    }
    return self;
}

@end
