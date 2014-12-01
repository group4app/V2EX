//
//  CoreStore+V2EX.m
//  V2EX
//
//  Created by Chris Huang on 14-8-17.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "CoreStore+V2EX.h"

@implementation CoreStore (V2EX)

- (void) addBookmarkWithNode:(NSDictionary *)node{
    
    NSMutableDictionary *newNode = [[NSMutableDictionary alloc] init];
    for(NSString *key in [node allKeys]){
        if(![node[key] isEqual:[NSNull null]]){
            [newNode setValue:node[key] forKey:key];
        }
    }
    
    NSArray *nodes = [self dataForKey:BOOKMARK];
    NSMutableArray *mutableNodes = [[NSMutableArray alloc] initWithArray:nodes];
    
    [mutableNodes addObject:newNode];
    
    [self setData:mutableNodes forKey:BOOKMARK];
}

- (void) removeBookmarkWithNodeId:(NSNumber *)nodeId{
    
    NSArray *nodes = [self dataForKey:BOOKMARK];
    NSMutableArray *mutableNodes = [[NSMutableArray alloc] initWithArray:nodes];
    
    for(NSDictionary *node in mutableNodes){
        if([node[@"id"] isEqualToNumber:nodeId]){
            [mutableNodes removeObject:node];
            break;
        }
    }
    
    [self setData:mutableNodes forKey:BOOKMARK];
}

- (NSArray*) allBookmarks{
    
    return [self dataForKey:BOOKMARK];
}

- (BOOL) isBookmarkContainNodeId:(NSNumber *)nodeId{
    
    NSArray *nodes = [self dataForKey:BOOKMARK];
    for(NSDictionary *node in nodes){
        if([node[@"id"] isEqualToNumber:nodeId]){
            return YES;
        }
    }
    
    return NO;
}



@end
