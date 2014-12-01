//
//  BookmarkItemCell.m
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "BookmarkItemCell.h"
#import "UIColor+GL.h"
#import "UIView+Frame.h"
#import "NSString+Html.h"
#import "Node.h"

#define MAX_OFFSET 70

typedef enum {
    BookmarkCellNormal,
    BookmarkCellDelete
}BookmarkCellState;

@implementation BookmarkItemCell{
    
    CGPoint             _startPoint;
    BookmarkCellState   _state;
    CGFloat             _originalX;
}

- (void)awakeFromNib
{
    self.titleLabel.textColor = [UIColor appMainColor];
    self.deleteButton.backgroundColor = [UIColor appMainColor];

}

- (void) setNode:(Node *)node{
    
    _node = node;
    self.titleLabel.text = node.title;
    self.subTitleLabel.text = [node.header htmlContent];
}

- (void) handlePan:(id)sender{
    
    UIPanGestureRecognizer *pan = sender;
    CGPoint point = [pan translationInView:self];
    CGFloat offset = point.x - _startPoint.x;
    if(_state==BookmarkCellNormal){
        _originalX = 0.0;
        offset = MIN(0, offset);
        offset = MAX(-MAX_OFFSET, offset);
    }
    else{
        _originalX = -MAX_OFFSET;
        offset = MAX(0, offset);
        offset = MIN(MAX_OFFSET, offset);
    }
    
    if(pan.state==UIGestureRecognizerStateBegan){
        _startPoint = point;
    }
    else if(pan.state==UIGestureRecognizerStateChanged){
        self.mainView.originX = _originalX + offset;
    }
    else{
        CGFloat newX = _originalX;
        if(fabs(offset)>MAX_OFFSET/2.0){
            newX += (offset/fabsf(offset))*MAX_OFFSET;
            _state -= (int)(offset/fabsf(offset));
        }
        [UIView animateWithDuration:.1 animations:^{
            self.mainView.originX = newX;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (IBAction)deleteButtonPressed:(id)sender{
    
    if(self.delegate){
        [self.delegate deleteCell:self];
    }
}




@end
