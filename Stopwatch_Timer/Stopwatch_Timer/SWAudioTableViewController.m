//
//  SWAudioTableViewController.m
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/29/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SWAudioTableViewController.h"

@interface SWAudioTableViewController ()

@property (nonatomic) NSArray *audioNames;
@property (nonatomic) AVAudioPlayer* audioSampler;

@end

@implementation SWAudioTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioNames = [[NSArray alloc] initWithObjects:@"Butt", @"HeavyAlarm", @"ShortAlarm", @"Klaxon", @"Warning", nil];
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    
    return self.audioNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AudioTableViewCell" forIndexPath:indexPath];
    
    cell.detailTextLabel.text = self.audioNames[indexPath.row];
   
    
    return cell;
}



@end
