//
//  MemberViewController.h
//  V2EX
//
//  Created by Chris Huang on 14-10-24.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberSectionHeader.h"

@class Member;

@interface MemberViewController : UITableViewController<MemberSectionHeaderDelegate>

@property(nonatomic,strong) Member      *member;

@end
