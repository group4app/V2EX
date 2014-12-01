//
//  Constants.h
//  V2EX
//
//  Created by Chris Huang on 14-7-4.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#ifndef V2EX_Constants_h
#define V2EX_Constants_h

#define V2EX_HOST                               @"http://www.v2ex.com"

#define SITE_STATUS                             @"/api/site/stats.json"
#define SITE_INFO                               @"/api/site/info.json"
#define NODES_ALL                               @"/api/nodes/all.json"
#define NODES_SHOW                              @"/api/nodes/show.json?id=%@"
#define TOPICS_LASTES                           @"/api/topics/latest.json"
#define TOPICS_HOT                              @"/api/topics/hot.json"
#define TOPICS_SHOW_USERNAME                    @"/api/topics/show.json?username=%@"
#define TOPICS_SHOW_NODE_ID                     @"/api/topics/show.json?node_id=%@"
#define REPLIES_SHOW                            @"/api/replies/show.json?topic_id=%@"
#define MEMBERS_SHOW                            @"/api/members/show.json?username=%@"


#define SITE_STATUS_PATH                        SITE_STATUS
#define SITE_INFO_PATH                          SITE_INFO
#define NODES_ALL_PATH                          NODES_ALL
#define NODES_SHOW_PATH(node_id)                [NSString stringWithFormat:NODES_SHOW,node_id]
#define TOPICS_LASTES_PATH                      TOPICS_LASTES
#define TOPICS_HOT_PATH                         TOPICS_HOT
#define TOPICS_SHOW_USERNAME_PATH(username)     [NSString stringWithFormat:TOPICS_SHOW_USERNAME,username]
#define TOPICS_SHOW_NODE_ID_PATH(node_id)       [NSString stringWithFormat:TOPICS_SHOW_NODE_ID,node_id]
#define REPLIES_SHOW_PATH(topic_id)             [NSString stringWithFormat:REPLIES_SHOW,topic_id]
#define MEMBERS_SHOW_PATH(username)             [NSString stringWithFormat:MEMBERS_SHOW,username]




#define MENU_ACTIVE_NOTIFICATION                @"MenuActiveNotification"







#define RGB_COLOR(r,g,b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]





#endif
