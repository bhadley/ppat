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
#import <Firebase/Firebase.h>

@interface UrgentTableViewController ()

@end

@implementation UrgentTableViewController

@synthesize residentImages = _residentImages;
@synthesize names = _names;
@synthesize textRequests = _textRequests;
@synthesize isUrgent = _isUrgent;
@synthesize isProcessed = _isProcessed;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"did load");
    
     //self.isUrgent = [[NSMutableArray alloc] init];
    

    /*self.isUrgent = @[@"y", @"n", @"y", @"n", @"n"];

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
                      @"william.png", nil];*/
    
    
    
    self.names = [[NSMutableArray alloc] init];
    
    self.textRequests = [[NSMutableArray alloc] init];
    self.residentImages = [[NSMutableArray alloc] init];
    
    self.idsFB = [[NSMutableArray alloc] init];
    self.namesFB = [[NSMutableArray alloc] init];
    //self.roomsFB = [[NSMutableArray alloc] init];
    self.picturesFB = [[NSMutableArray alloc] init];
    self.isProcessed = [[NSMutableArray alloc] init];
    
    // Create a reference to a Firebase location
    Firebase *userRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/users"];
    [userRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot* childSnap in snapshot.children) {
        [self.idsFB addObject:childSnap.name];
        [self.namesFB addObject:childSnap.value[@"name"]];
        //[self.roomsFB addObject:childSnap.value[@"room"]];
        [self.picturesFB addObject:childSnap.value[@"pic"]];
        
        

    }
    }];
    
    
    
    
    // Create a reference to a Firebase location
    Firebase *userRef1 = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/processed"];
    [userRef1 observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"is processed!");
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
        
        NSString *userID = snapshot.name; // snapshot.value[@"userID"];
        NSLog(@"%@", userID);
        NSInteger indexIntoArray = [self.names indexOfObject:userID];
        NSLog(@"%ld", (long)indexIntoArray);

     
        if(indexIntoArray < [self.isProcessed count] && indexIntoArray >= 0) {
            [self.isProcessed replaceObjectAtIndex:indexIntoArray withObject:@"true"];
            NSLog(@"%@",self.isProcessed);
            NSLog(@"isProcessed now true");
        } else {
            NSLog(@"isProcessed not true right now");
        }

        [self.tableView reloadData];
        
    }];
    

    
    
    
    // Create a reference to a Firebase location
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://bostonhome.firebaseio.com/requests"];
    [myRootRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        //NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
        
        NSString *userID = snapshot.name; // snapshot.value[@"userID"];
        NSInteger indexIntoArray = [self.namesFB indexOfObject:userID];
        //NSLog(@"%ld", (long)indexIntoArray);
        NSString *picture;
        if(indexIntoArray < [self.picturesFB count] && indexIntoArray >= 0) {
            
            //NSString *room = self.roomsFB[indexIntoArray];
            picture = self.picturesFB[indexIntoArray];
        } else {
            picture = @"defaulticon.png";
            
        }
        NSString *name = snapshot.name;
        //NSLog(@"%@", snapshot.value[@"isUrgent"]);
        
        //if([snapshot.value[@"isUrgent"]  isEqual: @"n"]) {
           // [self.isUrgent addObject:@"n"];
            [self.names addObject:name];
            [self.textRequests addObject:snapshot.value[@"text"]];
            [self.residentImages addObject:picture];
            [self.isProcessed addObject:@"false"];
       /* } else {
            NSInteger firstNo = [self.isUrgent indexOfObject:@"n"];
            if(NSNotFound == firstNo) {
                // TODO: create method since this is the same as above?
                [self.isUrgent addObject:@"y"];
                [self.names addObject:name];
                [self.textRequests addObject:snapshot.value[@"text"]];
                [self.residentImages addObject:picture];
            } else {
                [self.isUrgent insertObject:@"y" atIndex:firstNo];
                [self.names insertObject:name atIndex:firstNo];
                [self.textRequests insertObject:snapshot.value[@"text"] atIndex:firstNo];
                [self.residentImages insertObject:picture atIndex:firstNo];
            }
        }
        */
        [self.tableView reloadData];
    }];
    
    [myRootRef observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        
        //NSLog(@"Child removed");
         //NSLog(@"%@", snapshot.name);
        //NSLog(@"%@ -> %@", snapshot.name, snapshot.value[@"userID"]);
        //int userID = [snapshot.value[@"userID"] intValue]; // TODO: Convert
        //int userID = [snapshot.name intValue]; // TODO: Convert
        
         //NSString *name = self.idsFB.value[userID];
        // NSLog(@"%@",name);
        
        //NSString *name = self.names[userID-1];
       // NSLog(@"%@",name);
        NSInteger i = [self.names indexOfObject:snapshot.name];
        //for (int i=0; i<[self.names count]; i=i+1) {
            
            //if ([self.names[i] isEqual: name]) {
              //  NSLog(@"DELETING%@", i);
                [self.names removeObjectAtIndex:i];
                //[self.isUrgent removeObjectAtIndex:i];
                [self.textRequests removeObjectAtIndex:i];
                [self.residentImages removeObjectAtIndex:i];
                [self.isProcessed removeObjectAtIndex:i];

            //}
        //}
        
        [self.tableView reloadData];
    }];

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
  
    NSLog(@"%ld",[indexPath row]);
    
    if ([[self.isProcessed objectAtIndex: [indexPath row]]  isEqual: @"false"])  {
        CellIdentifier = @"textTableCell";
        NSLog(@"textTableCell");
    }
    else {
         NSLog(@"videoTableCell");
        CellIdentifier = @"videoTableCell";
    }
    
    UrgentTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UrgentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
     //cell.backgroundColor = [self colorWithHexString:@"FF4D4D"];
    /*
     if cell.processedStatus.text == @"false" {
        
    }
     */
    
    /*
     if ([[self.isProcessed objectAtIndex: [indexPath row]]  isEqual: @"false"]) {
         cell.backgroundColor = [self colorWithHexString:@"FF4D4D"];//red
        NSLog(@"red background color");
    }
    else {
        cell.backgroundColor = [UIColor greenColor];
         NSLog(@"green background color");
    }
    */
     
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
    // Configure the cell...
    cell.nameLabel.text = [self.names
                           objectAtIndex: [indexPath row]];
    
    //NSString *strValue = @([indexPath row]).stringValue;
    //NSLog([self.idsFB objectAtIndex: [indexPath row]]);
   // int b = indexPath - 1;
    //cell.userIDHiddenLabel.text = indexPath - 1]; //[self.idsFB objectAtIndex: [indexPath row]];
    cell.textLabel.text = [self.textRequests
                            objectAtIndex:[indexPath row]];
    
    UIImage *residentPhoto = [UIImage imageNamed:
                         [self.residentImages objectAtIndex: [indexPath row]]];
    
    cell.residentImage.image = residentPhoto;
    cell.processRequest.hidden = FALSE;
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
