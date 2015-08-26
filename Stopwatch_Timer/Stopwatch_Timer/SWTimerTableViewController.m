//
//  SWTimerTableViewController.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/22/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SWTimerTableViewController.h"
#import "SWTimerViewController.h"
#import "Timer.h"

@interface SWTimerTableViewController () 

@end

@implementation SWTimerTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.presetArrayOfDictionaries = [[NSMutableArray alloc] init];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.presetArrayOfDictionaries count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimerCellIdentifier" forIndexPath:indexPath];
    
    NSDictionary *temp = self.presetArrayOfDictionaries[indexPath.row];
    NSString *title = [temp objectForKey:@"name"];
    cell.textLabel.text = title;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * temp = [self.presetArrayOfDictionaries objectAtIndex:indexPath.row];
    Timer *timer = [temp objectForKey:@"timer"];
    SWTimerViewController *timerView = [[SWTimerViewController alloc]init];
   // timerView.timer =  timer;
    [self.navigationController pushViewController:timerView  animated:YES];
}

@end
