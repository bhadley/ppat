//
//  UrgentTableViewController.m
//  helloworldppat
//
//  Created by amadeus on 10/25/14.
//  Copyright (c) 2014 amadeus. All rights reserved.
//

#import "UrgentTableViewController.h"
#import "UrgentTableViewCell.h"
#import "utils.h"
//#import <Firebase/Firebase.h>

@interface UrgentTableViewController ()

@end

@implementation UrgentTableViewController

@synthesize residentImages = _residentImages;
@synthesize names = _names;
@synthesize textRequests = _textRequests;
@synthesize isUrgent = _isUrgent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"did load");

    self.isUrgent = @[@"y", @"n", @"y", @"n", @"n"];

    self.names = [[NSArray alloc]
                     initWithObjects:@"Margaret",
                     @"Laura",
                     @"Tanya",
                     @"Beth",
                     @"William", nil];
    
    self.textRequests = [[NSArray alloc]
                      initWithObjects:@"Water please!",
                      @"video",
                      @"Please send aid",
                      @"video",
                      @"Please send aid", nil];
    
    self.residentImages = [[NSArray alloc]
                      initWithObjects:@"margaret.png",
                      @"laura.png",
                      @"tanya.png",
                      @"beth.png",
                      @"william.png", nil];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NSString *textString = [self.textRequests
                            objectAtIndex:[indexPath row]];

    static NSString *CellIdentifier;
    
    if ( [textString  isEqual: @"video"] == 1 ) {
        CellIdentifier = @"videoTableCell";
    }
    else {
        CellIdentifier = @"textTableCell";
    }
    
    UrgentTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UrgentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    
    if ( [[self.isUrgent objectAtIndex: [indexPath row] ]  isEqual: @"y"]) {
        cell.backgroundColor = [self colorWithHexString:@"FF8D71"];
    }
    else {
        cell.backgroundColor = [self colorWithHexString:@"FFFFC0"];
    }
    
    
    // Configure the cell...
    cell.nameLabel.text = [self.names
                           objectAtIndex: [indexPath row]];
    

    
    cell.textLabel.text = [self.textRequests
                            objectAtIndex:[indexPath row]];
    
    UIImage *residentPhoto = [UIImage imageNamed:
                         [self.residentImages objectAtIndex: [indexPath row]]];
    
    cell.residentImage.image = residentPhoto;
    
    return cell;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
