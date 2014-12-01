//
//  AccountCell.m
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "AccountCell.h"
#import "UIColor+GL.h"
#import "UIImage+Color.h"


@implementation AccountCell

- (void)awakeFromNib
{

    UIImage *image = [self.avatarButton imageForState:UIControlStateNormal];
    [self.avatarButton setImage:[image imageTintedWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    self.nameLabel.hidden = YES;
    self.loginButton.backgroundColor = RGB_COLOR(44, 44, 48);
    
}

@end
