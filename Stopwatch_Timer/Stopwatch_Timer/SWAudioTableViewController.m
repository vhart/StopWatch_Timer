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
@property (nonatomic) NSIndexPath *selectionIndexPath;
@property (nonatomic) AVAudioPlayer* audioSampler;
@property (nonatomic) NSString* stringToPass;

@end

@implementation SWAudioTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioNames = [[NSArray alloc] initWithObjects:@"Beeps", @"HeavyAlarm", @"ShortAlarm", @"Klaxon", @"Warning", nil];
   
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.audioSampler stop];
    NSString* audioString = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], self.audioNames[indexPath.row]];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: audioString];
    
    self.audioSampler =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    [self.audioSampler play];
    
    self.selectionIndexPath = indexPath;
    self.stringToPass = self.audioNames[indexPath.row];
    NSLog(@"%@", self.stringToPass);
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AudioTableViewCell" forIndexPath:indexPath];
    
    cell.detailTextLabel.text = self.audioNames[indexPath.row];
    
    if ([self.selectionIndexPath isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
   
    
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    
    
    [self.delegate didSelectAudioFilename:self.stringToPass];
    NSLog(@"%@", self.stringToPass);
    
}


@end
