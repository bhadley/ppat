//
//  UITableView+utils.h
//  helloworldppat
//
//  Created by amadeus on 11/1/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

@interface UIViewController(utils)

-(UIColor*)colorWithHexString:(NSString*)hex;
-(void)requestForUserID:(NSString*)userID withRequest:(NSString*)request;
-(void)cancelRequestForUserID:(NSString*)userID ;
extern NSString *const firebaseURL_log;
extern NSString *const firebaseURL_requests;
extern NSString *const firebaseURL_users;
extern NSString *const firebaseURL_processed;
@end