//
//  UITableView+utils.m
//
//  Created by bhadley on 11/1/14.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Methods and variables referenced throughout app are stored in utils
//  and can be referenced by importing utils.h
//  ------------------------------------------------------------------------

#import <Firebase/Firebase.h>

#import "utils.h"
@interface utils()
@end
//@implementation UIViewController(utils)
@implementation utils

/*
The application stores information in firebase, for communication between
 resident side and nurse side. For developmental purposes, use "tbhdev". For deployment, use "thebostonhome".
*/

NSString * const FB_LOG = @"https://tbhdev.firebaseio.com/log";
NSString * const FB_REQUESTS = @"https://tbhdev.firebaseio.com/requests";
NSString * const FB_USERS = @"https://tbhdev.firebaseio.com/users";
NSString * const FB_PROCESSED = @"https://tbhdev.firebaseio.com/processed";


/* the floor toggle variable specifies which requests should be received based
    on the resident's floor.
        0: 1st floor residents only 
        1: 2nd floor residents only
        2: all residents
    this variable may be set by the nurse's app by triple tapping on the home screen
 */
NSInteger nurseFloorToggle = 0;

/*
 Return the current time in a nicely formatted string YYYY-MM-DD HH:MM:SS
 */
+(NSString*)getTimeStamp {
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}

/*
 Send resident's request to firebase, and create an entry in the firebase
 log to record this event
 @param userName resident's name
 @param request string request (as string) to be sent
 */
+(void)sendRequestForUser:(NSString*)userName withRequest:(NSString*)request
{

    Firebase *myRootRef = [[Firebase alloc] initWithUrl:FB_REQUESTS];
    
    // Prepare timestamp
    NSString *timeStamp = [self getTimeStamp];
   
    // Log request in firebase
    NSDictionary *post1 = @{
                            @"text": request,
                            @"timestamp":timeStamp
                            };
    Firebase *post1Ref = [myRootRef childByAppendingPath: userName];
    [post1Ref setValue: post1 ];
    
    // Send request to firebase
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:FB_LOG];
    NSDictionary *post2 = @{
                            @"user": userName,
                            @"text": request,
                            @"timestamp":timeStamp
                            };
    
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];
}

@end