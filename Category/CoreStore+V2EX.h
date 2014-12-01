//
//  CoreStore+V2EX.h
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "CoreStore.h"

#define BOOKMARK    @"bookmark"

@interface CoreStore (V2EX)

- (void) addBookmarkWithNode:(NSDictionary*)node;

- (void) removeBookmarkWithNodeId:(NSNumber*)nodeId;

- (NSArray*) allBookmarks;

- (BOOL) isBookmarkContainNodeId:(NSNumber*)nodeId;

@end
