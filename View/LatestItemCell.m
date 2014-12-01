//
//  LatestItemCell.m
//  V2EX
//
//  Created by Chris Huang on 14-7-15.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "LatestItemCell.h"
#import <UIImageView+AFNetworking.h>
#import "NSDate+General.h"

@implementation LatestItemCell

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
    
    NSString *avatarUrlString = topic[@"member"][@"avatar_normal"];
    if([avatarUrlString rangeOfString:@"http"].location==NSNotFound){
        avatarUrlString = [NSString stringWithFormat:@"http:%@",avatarUrlString];
    }
    NSURL *avatarUrl = [NSURL URLWithString:avatarUrlString];
    [self.avatarView setImageWithURL:avatarUrl];
    
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:[topic[@"created"] doubleValue]];
    self.dateLabel.text = [create stringWithFormat:@"yyyy-MM-dd HH:mm"];
    self.idLabel.text = topic[@"member"][@"username"];
    self.titleLabel.text = topic[@"title"];
    self.groupLabel.text = topic[@"node"][@"title"];
    
}


@end
