//
//  SnsLinkView.h
//  V2EX
//
//  Created by Chris Huang on 14-8-6.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnsLinkView : UIView

@property(nonatomic,retain) IBOutlet UIImageView        *linkPicView;
@property(nonatomic,retain) IBOutlet UILabel            *titleLabel;
@property(nonatomic,retain) IBOutlet UILabel            *contentLabel;

@property(nonatomic,retain) NSDictionary    *pageInfo;

@end
