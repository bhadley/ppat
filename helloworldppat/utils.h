//
//  UITableView+utils.h
//  helloworldppat
//
//  Created by amadeus on 11/1/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

@interface UIViewController(utils)

-(UIColor*)colorWithHexString:(NSString*)hex;
-(void)requestIsUrgent:(BOOL)urgency forUser:(NSString*)userID withRequest:(NSString*)request;

@end