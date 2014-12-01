//
//  MemberSectionHeader.h
//  V2EX
//
//  Created by Chris Huang on 14-10-26.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Xib.h"

@class MemberSectionHeader;

@protocol MemberSectionHeaderDelegate <NSObject>

- (void) sectionHeader:(MemberSectionHeader*)header openAtSection:(NSInteger)section;
- (void) sectionHeader:(MemberSectionHeader*)header closedAtSection:(NSInteger)section;

- (void) sectionHeader:(MemberSectionHeader*)header moreAtSection:(NSInteger)section;

@end

@interface MemberSectionHeader : UIView

@property(nonatomic,weak) IBOutlet UIButton      *navButton;
@property(nonatomic,weak) IBOutlet UILabel       *titleLabel;
@property(nonatomic,weak) IBOutlet UIButton      *moreButton;

@property(nonatomic,weak) id<MemberSectionHeaderDelegate> delegate;

- (void) navStatusChangedWithUserAction:(BOOL)userAction;

@end
