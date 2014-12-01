//
//  NodeItemCell.m
//  V2EX
//
//  Created by Chris Huang on 14-8-14.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "NodeItemCell.h"
#import "UIColor+GL.h"
#import "UIImage+Color.h"
#import "CoreStore+V2EX.h"
#import "NSString+Html.h"
#import "Node.h"

@implementation NodeItemCell

- (void) awakeFromNib{
    
    self.titleLabel.textColor = [UIColor appMainColor];
    UIImage *normalImage = [self.optButton imageForState:UIControlStateNormal];
    [self.optButton setImage:[normalImage imageTintedWithColor:[UIColor appMainColor]] forState:UIControlStateNormal];
    
    UIImage *disableImage = [self.optButton imageForState:UIControlStateDisabled];
    [self.optButton setImage:[disableImage imageTintedWithColor:[UIColor appMainColor]] forState:UIControlStateDisabled];
}


- (void) setNode:(Node *)node{
    
    _node = node;
    
    self.titleLabel.text = node.title;
    self.subTitleLabel.text = [node.header htmlContent];

    if([[CoreStore sharedStore] isBookmarkContainNodeId:@(node.identifier)]){
        self.optButton.enabled = NO;
    }
    else{
        self.optButton.enabled = YES;
    }
}

- (IBAction) optButtonPressed:(id)sender{
    
    
    [[CoreStore sharedStore] addBookmarkWithNode:[self.node toDictionary]];
    
    ((UIButton*)sender).enabled = NO;
}

@end
