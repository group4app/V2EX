//
//  SnsRetweetedView.m
//  V2EX
//
//  Created by Chris Huang on 14-8-6.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "SnsRetweetedView.h"
#import "SnsLinkView.h"
#import <UIButton+AFNetworking.h>
#import "UIView+Xib.h"
#import "UIView+Frame.h"

@implementation SnsRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setTopic:(NSDictionary *)topic{
    
    _topic = topic;
    
    NSString *text = self.topic[@"text"];
    NSString *content = [NSString stringWithFormat:@"@%@: %@",self.topic[@"user"][@"screen_name"],text];
    self.contentLabel.text = content;
    
    for(UIView *view in self.containerView.subviews){
        [view removeFromSuperview];
    }
    
    
    if(self.topic[@"pic_infos"]){
        [self configPictures];
    }
    else if(self.topic[@"page_infos"]){
        [self configLink];
    }
    else{
        CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.sizeH = size.height;
    }
    
}

- (void) configPictures{
    
    CGFloat padding = 8.0;
    CGFloat offsetX = padding;
    CGFloat offsetY = padding;
    CGFloat picWidth = 96;
    NSInteger index = 0;
    for(NSString *picId in self.topic[@"pic_ids"]){
        
        NSString *picUrl = self.topic[@"pic_infos"][picId][@"original"][@"url"];
        
        UIButton *picButton = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, offsetY, picWidth, picWidth)];
        picButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [picButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:picUrl]];
        picButton.clipsToBounds = YES;
        picButton.tag = index++;
        [picButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:picButton];
        
        offsetX += picWidth + padding;
        if(offsetX+picWidth>self.containerView.frame.size.width){
            offsetX = padding;
            offsetY += picWidth + padding;
        }
    }
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSInteger picCount = [self.topic[@"pic_ids"] count];
    CGFloat containerHeight = ((picCount-1)/3+1)*104;
    self.sizeH = size.height + containerHeight;
}



- (void) configLink{
    
    SnsLinkView *linkView = (SnsLinkView *)[SnsLinkView viewFromXib];
    linkView.pageInfo = self.topic[@"page_info"];
    [self.containerView addSubview:linkView];
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.sizeH = size.height + linkView.frame.size.height;
    
}

- (void) buttonPressed:(UIButton*)button{
    
    if(self.delegate){
        NSMutableArray *picUrls = [[NSMutableArray alloc] init];
        for(NSString *picId in self.topic[@"pic_ids"]){
            NSString *picUrl = self.topic[@"pic_infos"][picId][@"original"][@"url"];
            [picUrls addObject:picUrl];
        }
        [self.delegate selectPhoto:picUrls atIndex:button.tag];
    }
}

@end
