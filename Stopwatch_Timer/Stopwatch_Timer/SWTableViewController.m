//
//  SWTableViewController.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SWTableViewController.h"

@interface SWTableViewController ()

@end

@implementation SWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lapTimesArray = [[NSMutableArray alloc] init];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lapTimesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LapsCellIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %lu",self.lapTimesArray.count - indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lf",[self.lapTimesArray[indexPath.row] doubleValue]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Liquid Crystal" size:17.0];
    
    return cell;
}




@end
