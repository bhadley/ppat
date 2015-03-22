//
//  NurseViewController.h
//
//  Created by bhadley on 10/25/14.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NurseViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *rooms;
@property (nonatomic, strong) NSMutableArray *textRequests;
@property (nonatomic, strong) NSMutableArray *isProcessed;

@property (nonatomic, strong) NSMutableArray *namesFB;
@property (nonatomic, strong) NSMutableArray *roomsFB;

@end