//
//  UITableView+utils.h
//
//  Created by bhadley on 11/1/14.
//  Copyright (c) 2015. All rights reserved.
//

//@interface UIViewController(utils)
@interface utils : UIViewController

+(void)sendRequestForUser:(NSString*)userID withRequest:(NSString*)request;
+(NSString*)getTimeStamp;

extern NSString *  FB_LOG;
extern NSString *  FB_REQUESTS;
extern NSString *  FB_USERS;
extern NSString *  FB_PROCESSED;

extern NSInteger nurseFloorToggle;
@end