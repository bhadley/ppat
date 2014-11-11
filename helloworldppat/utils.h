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
@end