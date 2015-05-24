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
+(void)instantiateFBVars:(NSString*)loginCode;
+(bool)loginCodeValid:(NSString*)loginCode;
    
extern NSString *  FB_IDSTRING;
extern NSString *  FACETIME_APPLEID;

extern NSString *  FB_LOG;
extern NSString *  FB_REQUESTS;
extern NSString *  FB_USERS;
extern NSString *  FB_PROCESSED;
extern NSString *  FB_NURSE_IPAD_HEARTBEAT;
extern NSInteger nurseFloorToggle;
@end