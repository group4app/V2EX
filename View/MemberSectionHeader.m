//
//  MemberSectionHeader.m
//  V2EX
//
//  Created by Chris Huang on 14-10-26.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "MemberSectionHeader.h"

@implementation MemberSectionHeader

- (IBAction)navButtonPressed:(id)sender{
    
    [self navStatusChangedWithUserAction:YES];
}

- (IBAction)moreButtonPressed:(id)sender{
    
    if(self.delegate){
        [self.delegate sectionHeader:self moreAtSection:self.tag];
    }
    
}

- (void) navStatusChangedWithUserAction:(BOOL)userAction{
    
    if(userAction){
        if(self.navButton.selected){
            if(self.delegate){
                [self.delegate sectionHeader:self closedAtSection:self.tag];
            }
        }
        else{
            if(self.delegate){
                [self.delegate sectionHeader:self openAtSection:self.tag];
            }
        }
    }
    
    self.navButton.selected = !self.navButton.selected;
    
}

@end
