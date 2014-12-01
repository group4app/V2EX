//
//  Node.h
//  V2EX
//
//  Created by Chris Huang on 14-10-23.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@protocol Node

@end

@interface Node : JSONModel

@property(nonatomic,assign) NSInteger               identifier;
@property(nonatomic,strong) NSString                *name;
@property(nonatomic,strong) NSString                *url;
@property(nonatomic,strong) NSString                *title;
@property(nonatomic,strong) NSString<Optional>      *titleAlternative;
@property(nonatomic,assign) NSInteger               topics;
@property(nonatomic,strong) NSString<Optional>      *header;
@property(nonatomic,strong) NSString<Optional>      *footer;
@property(nonatomic,assign) NSInteger               created;

@end
