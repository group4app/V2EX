//
//  SnsPhotoCellDelegate.h
//  V2EX
//
//  Created by Chris Huang on 14-8-7.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SnsPhotoCellDelegate <NSObject>

- (void) selectPhoto:(NSArray*)photos atIndex:(NSInteger)index;

@end
