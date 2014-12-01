//
//  SnsWallCell.m
//  V2EX
//
//  Created by Chris Huang on 14-8-5.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "SnsPostCell.h"
#import "NSDate+General.h"
#import <UIImageView+AFNetworking.h>
#import <UIButton+AFNetworking.h>
#import "UIView+Xib.h"
#import "SnsLinkView.h"
#import "SnsRetweetedView.h"
#import "UIView+Frame.h"

@implementation SnsPostCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    
}

- (void) setTopic:(NSDictionary *)topic{
    
    _topic = topic;
    
    //avatar image
    NSString *avatarUrl = topic[@"user"][@"avatar_large"];
    [self.avatarView setImageWithURL:[NSURL URLWithString:avatarUrl]];
    
    //user name
    self.nameLabel.text = topic[@"user"][@"screen_name"];
    
    //create date
    NSString *dateStr = topic[@"created_at"];
    NSDate *date = [NSDate dateFromString:dateStr format:@"EEE MMM dd HH:mm:ss Z yyyy"];
    self.dateLabel.text = [date stringWithFormat:@"yyyy-MM-dd hh:mm"];
    
    //content
    self.contentLabel.text = topic[@"text"];
    [self.contentLabel markWithSymbol:@"@" Color:[UIColor blueColor] font:[UIFont systemFontOfSize:15]];
    [self.contentLabel markWithStartSymbol:@"#" endSymbol:@"#" color:[UIColor blueColor] font:[UIFont systemFontOfSize:15]];
    [self.contentLabel markLinkWithColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
    [self.contentLabel showSymbols];
    
    for(UIView *view in self.containerView.subviews){
        [view removeFromSuperview];
    }
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.actualCellHeight = size.height;
    
    if(self.topic[@"page_info"]){
        [self configLink];
    }
    else if(self.topic[@"pic_infos"]){
        [self configPictures];
    }
    else if(self.topic[@"retweeted_status"]){
        [self configRetweeted];
    }
    
}

- (void) setDelegate:(id<SnsPhotoCellDelegate>)delegate{
    
    _delegate = delegate;
    for(UIView *view in self.containerView.subviews){
        if([view isKindOfClass:[SnsRetweetedView class]]){
            ((SnsRetweetedView*)view).delegate = delegate;
        }
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
    
    
    NSInteger picCount = [self.topic[@"pic_ids"] count];
    CGFloat containerHeight = ((picCount-1)/3+1)*104;
    self.actualCellHeight += containerHeight;
}


- (void) configRetweeted{
    
    SnsRetweetedView *retweetedView = (SnsRetweetedView*)[SnsRetweetedView viewFromXib];
    retweetedView.topic = self.topic[@"retweeted_status"];
    [self.containerView addSubview:retweetedView];
    
    self.actualCellHeight += retweetedView.size.height;
    
    if(self.delegate){
        retweetedView.delegate = self.delegate;
    }
}

- (void) configLink{
    
    SnsLinkView *linkView = (SnsLinkView *)[SnsLinkView viewFromXib];
    linkView.pageInfo = self.topic[@"page_info"];
    [self.containerView addSubview:linkView];
    
    self.actualCellHeight += linkView.frame.size.height;
    
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
