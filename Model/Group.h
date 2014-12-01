//
//  Group.h
//  V2EX
//
//  Created by Chris Huang on 14-10-30.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import <JSONModel.h>

@interface Group : JSONModel

@property(nonatomic,strong) NSString        *name;
@property(nonatomic,strong) NSArray<Node>   *nodes;

@end
