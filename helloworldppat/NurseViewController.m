//
//  NurseViewController.m
//
//  Created by bhadley on 10/25/14.
//  Copyright (c) 2015. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Update the Nurse's display according to changes in firebase.
//  ------------------------------------------------------------------------


#import "NurseViewController.h"
#import "NurseTableViewCell.h"
#import <Firebase/Firebase.h>
#import <AudioToolbox/AudioToolbox.h>

@interface NurseViewController ()

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;

@end

@implementation NurseViewController

@synthesize names = _names;
@synthesize rooms = _rooms;
@synthesize textRequests = _textRequests;

NSMutableArray* isProcessedList;
NSMutableArray* textRequests;

int emergencySoundID = 1030; //sherwood forest
int normalSoundID = 1027; //minuet
int soundID = 0;

/*
 Return true if there exists any request in the nurse table that is not
 processed, false otherwise
 */
bool anyRequestsNotProcessed(){
    return [isProcessedList containsObject:@"false"];
}

/*
 Decide whether the resident's request should be handled, depending on 
 the variable nurseFloorToggle (see utils)
 @param residentsFloor: "1" or "2"
 @return true/false
 */
- (bool) handleThisUserRequest:(NSString *) residentsFloor {
    return ( (nurseFloorToggle == 0 && [residentsFloor  isEqual: @"1"]) ||      (nurseFloorToggle == 1 && [residentsFloor  isEqual: @"2"]) || (nurseFloorToggle == 2) );
}

/*
 If any requests are not processed, play sounds repeatedly until all requests are
 processed. If any of the requests are EMERGENCY requests, play the the emergencySoundID. If not, play normalSoundID.
 */
void playNotificationSound()
{
    if (anyRequestsNotProcessed() == true) {
        soundID = normalSoundID;
        if ([textRequests containsObject:@"EMERGENCY!! Send help immediately!!!"] == true){
            soundID = emergencySoundID;
        }
        
        AudioServicesDisposeSystemSoundID(emergencySoundID);
        AudioServicesDisposeSystemSoundID(normalSoundID);
        AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,playNotificationSound,NULL);
        AudioServicesPlaySystemSound(soundID);
        
    }
    
}

/*
 If the screen is tapped three times, display a page of settings, which allows
 nurses to toggle between viewing requests from residents on floor 1/2/both.
 */
- (IBAction)respondToTripleTap:(UITapGestureRecognizer *)recognizer {
    UIViewController *vc;
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NurseViewSettings"];
    [self presentViewController:vc animated:NO completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the triple tap gesure listener
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTripleTap:)];
    tapRecognizer.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:tapRecognizer];
    
    // create a timer that checks the wifi connection every minute. If no connection
    // found, notify user with a popup message.
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 60 target: self
        selector: @selector(checkWifiStatus:) userInfo: nil repeats: YES];
   
    
    // create local storage dictionaries for data displayed in cells
    // this data is read from and written to firebase
    self.names = [[NSMutableArray alloc] init];
    self.textRequests = [[NSMutableArray alloc] init];
    self.rooms = [[NSMutableArray alloc] init];

    self.namesFB = [[NSMutableArray alloc] init];
    self.roomsFB = [[NSMutableArray alloc] init];
    self.isProcessed = [[NSMutableArray alloc] init];
    
    Firebase *FIREBASE_USERS = [[Firebase alloc] initWithUrl:FB_USERS];
    
    // FOR EACH USER IN FIREBASE USERS
    [FIREBASE_USERS observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot* childSnap in snapshot.children) {
            [self.namesFB addObject:childSnap.value[@"name"]];
            [self.roomsFB addObject:childSnap.value[@"room"]];
        }
    }];
    
    // IF USER ROOM NUMBER CHANGES IN FIREBASE, UPDATE INTERNAL VARIABLES
    [FIREBASE_USERS observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        NSString *userName = snapshot.value[@"name"];
        NSInteger indexIntoArray = [self.namesFB indexOfObject:userName];
        [self.roomsFB replaceObjectAtIndex:indexIntoArray withObject:snapshot.value[@"room"] ];
    }];
    
    // REQUEST ADDED TO FIREBASE PROCESSED LIST
    Firebase *FIREBASE_PROCESSED = [[Firebase alloc] initWithUrl:FB_PROCESSED];
    [FIREBASE_PROCESSED observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        NSString *userName = snapshot.name;
        NSInteger indexIntoArray = [self.names indexOfObject:userName];
        
        if(indexIntoArray < [self.isProcessed count] && indexIntoArray >= 0) {
            [self.isProcessed replaceObjectAtIndex:indexIntoArray withObject:@"true"];
            isProcessedList = self.isProcessed;

            if (anyRequestsNotProcessed() == false) {
                AudioServicesDisposeSystemSoundID(soundID);
            }
        }

        [self.tableView reloadData];
    }];
    
    // REQUEST ADDED TO FIREBASE REQUESTS LIST
    Firebase *FIREBASE_REQUESTS = [[Firebase alloc] initWithUrl:FB_REQUESTS];
    [FIREBASE_REQUESTS observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        NSString *userName = snapshot.name;
        NSInteger indexIntoArray = [self.namesFB indexOfObject:userName];
        
        NSString *floorNumber = [self.roomsFB[indexIntoArray] substringToIndex:1 ];
        
        if ([self handleThisUserRequest: floorNumber] == true ) {
            NSString *name = snapshot.name;

            [self.names addObject:name];
            [self.textRequests addObject:snapshot.value[@"text"]];
            [self.isProcessed addObject:@"false"];
            [self.rooms addObject:self.roomsFB[indexIntoArray]];
        
            isProcessedList = self.isProcessed;
            textRequests = self.textRequests;
          
            playNotificationSound();
        
        }
        [self.tableView reloadData];
    }];
    
    // REQUEST REMOVED FROM FIREBASE REQUESTS LIST
    [FIREBASE_REQUESTS observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        
        NSInteger i = [self.names indexOfObject:snapshot.name];
        if (i != NSNotFound) {
            [self.names removeObjectAtIndex:i];
            [self.textRequests removeObjectAtIndex:i];
            [self.isProcessed removeObjectAtIndex:i];
            [self.rooms removeObjectAtIndex:i];
            
            isProcessedList = self.isProcessed;
            textRequests = self.textRequests;
        }
        if (anyRequestsNotProcessed() == false) {
            AudioServicesDisposeSystemSoundID(emergencySoundID);
            AudioServicesDisposeSystemSoundID(normalSoundID);
        }
        [self.tableView reloadData];
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.names count];
}

// UPDATE TABLE VIEW DISPLAY
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier;
    
    if ([[self.isProcessed objectAtIndex: [indexPath row]]  isEqual: @"false"])  {
        CellIdentifier = @"notProcessedCell";
    }
    else {
        CellIdentifier = @"processedCell";
    }
    
    NurseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[NurseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Update cell data
    cell.nameLabel.text = [self.names objectAtIndex: [indexPath row]];
    cell.textLabel.text = [self.textRequests objectAtIndex:[indexPath row]];
    cell.roomLabel.text = [self.rooms objectAtIndex:[indexPath row]];
    cell.processRequest.hidden = FALSE;
    return cell;
}

-(void) checkWifiStatus:(NSTimer*) t
{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        NSLog(@"Device is connected to the internet");
    }
    else {
        NSLog(@"Device is not connected to the internet");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
