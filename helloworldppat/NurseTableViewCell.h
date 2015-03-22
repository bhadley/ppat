//
//  NurseTableViewCell.h
//
//  Created by bhadley on 10/25/14.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NurseTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UILabel *roomLabel;
@property (nonatomic, strong) IBOutlet UIButton *processRequest;
@property (nonatomic, strong) IBOutlet UIButton *cancelRequest;

- (IBAction)cancelRequest:(id)sender;
- (IBAction)requestProcessed:(id)sender;
@end
