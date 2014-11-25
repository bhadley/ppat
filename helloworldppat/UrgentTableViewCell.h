//
//  UrgentTableViewCell.h
//  helloworldppat
//
//  Created by amadeus on 10/25/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UrgentTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *residentImage;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UILabel *userIDHiddenLabel;
@property (nonatomic, strong) IBOutlet UIButton *processRequest;
@property (nonatomic, strong) IBOutlet UIButton *cancelRequest;
@property (nonatomic, strong) IBOutlet UILabel *processedStatus;
- (IBAction)cancelRequest:(id)sender;


- (IBAction)requestProcessed:(id)sender;
@end
