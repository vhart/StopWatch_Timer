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
    
    self.presetArrayOfDictionaries = [[NSMutableArray alloc] initWithObjects:   @{@"name":@"Running",@"timer":[[Timer alloc]
                               initWithHours:0 minutes:30]},
                           @{@"name":@"Popcorn",@"timer":[[Timer alloc] initWithHours:0 minutes:3]},
                           @{@"name":@"Workout",@"timer":[[Timer alloc] initWithHours:1 minutes:30]},
                           @{@"name":@"Baked Potato",@"timer":[[Timer alloc] initWithHours:0 minutes:5]},
                           @{@"name":@"Presentation Timer",@"timer":[[Timer alloc] initWithHours:0 minutes:3]},
                           @{@"name":@"Blueberry Muffins",@"timer":[[Timer alloc] initWithHours:0 minutes:20]},
                            @{@"name":@"Pods", @"timer":[[Timer alloc] initWithHours:1 minutes:0]},
                                      nil];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.presetArrayOfDictionaries count]+1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetsCellIdentifier" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text =  @"Add New Preset!";
        [cell.textLabel setTextColor:[UIColor greenColor]];
    }
    else{
    NSDictionary *temp = self.presetArrayOfDictionaries[indexPath.row -1];
    NSString *title = [temp objectForKey:@"name"];
    cell.textLabel.text = title;
    
    Timer *timer = [temp objectForKey:@"timer"];
    cell.detailTextLabel.text = [[timer timeStringFromTimer]substringToIndex:5];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * temp = [self.presetArrayOfDictionaries objectAtIndex:indexPath.row];
    [self.delegate dictionaryForTimerSelected:temp];
}

@end
