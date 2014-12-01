//
//  SnsLinkView.m
//  V2EX
//
//  Created by Chris Huang on 14-8-6.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "SnsLinkView.h"
#import <UIImageView+AFNetworking.h>

@implementation SnsLinkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setPageInfo:(NSDictionary *)pageInfo{
    
    _pageInfo = pageInfo;
    
    NSString *picUrl = self.pageInfo[@"page_pic"];
    [self.linkPicView setImageWithURL:[NSURL URLWithString:picUrl]];
    
    self.titleLabel.text = self.pageInfo[@"page_title"];
    if(self.pageInfo[@"content1"])
        self.contentLabel.text = self.pageInfo[@"content1"];
    else
        self.contentLabel.text = self.pageInfo[@"page_desc"];
    
    
}


@end
