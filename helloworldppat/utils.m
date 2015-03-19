//
//  UITableView+utils.m
//  helloworldppat
//
//  Created by amadeus on 11/1/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//
#import <Firebase/Firebase.h>

@implementation UIViewController(utils)

NSString *const firebaseURL_log = @"https://tbhdev.firebaseio.com/log";
NSString *const firebaseURL_requests = @"https://tbhdev.firebaseio.com/requests";
NSString *const firebaseURL_users = @"https://tbhdev.firebaseio.com/users";
NSString *const firebaseURL_processed = @"https://tbhdev.firebaseio.com/processed";

NSInteger floorToggleMaster = 0;

-(void)requestForUserID:(NSString*)userID withRequest:(NSString*)request
//-(void)sendrequest:(BOOL)urgency forUser:(NSString*)userID
{

    // Create a reference to a Firebase location
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:firebaseURL_requests];
    // Write data to Firebase
   // NSArray *persons = [NSArray arrayWithObjects:@"1","video","timestamp"];
    NSLog(@"requestForUserIDhere");
    
    //NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
 
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
   
    
    NSDictionary *post1 = @{
                            //@"userID":userID,
                            @"text": request,
                            @"timestamp":resultString
                            };
    Firebase *post1Ref = [myRootRef childByAppendingPath: userID];
    [post1Ref setValue: post1 /*withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            NSLog(@"error connecting to firebase!");
            NSLog(@"%@", error);
        } else {
            NSLog(@"success connecting to firebase!");
        }
    }*/];
    
   // NSString *postId = post1Ref.name;
    
    //[myRootRef childByAutoId:@"Do you have noms? You'll love Firebase."];
    
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:firebaseURL_log];
    NSDictionary *post2 = @{
                            @"user": userID,
                            @"text": request,
                            @"timestamp":resultString
                            };

    
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];

}

/*
- (void)cancelRequestForUser:(NSString*)userID {
    NSLog(@"user cancelled request");
    Firebase *fb = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@", @"https://bostonhome.firebaseio.com/requests/", userID]];
    [fb removeValue];
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    Firebase *fbRequestLog = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/log"];
    NSDictionary *post2 = @{@"user":userID,@"text": @"User cancelled request",@"timestamp":resultString};
    Firebase *postRef = [fbRequestLog childByAutoId];
    [postRef setValue: post2];
    
}
 */

/*
-(void)processUserRequest:(NSString*)userID
//-(void)sendrequest:(BOOL)urgency forUser:(NSString*)userID
{
    // Create a reference to a Firebase location
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/processed"];
    // Write data to Firebase
    [myRootRef childByAppendingPath: userID];
}
*/

@end