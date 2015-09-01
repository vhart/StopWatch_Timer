//
//  SEViewController.m
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/27/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SEViewController.h"
#import "MemoViewController.h"


@interface SEViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *eventsArray;
@property (nonatomic) NSTimer* eventsTimer;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;


@end

@implementation SEViewController

// In each tabbed view controller
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        // non-selected tab bar image
        UIImage *defaultImage = [[UIImage imageNamed:@"calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // selected tab bar image
        UIImage *selectedImage = [[UIImage imageNamed:@"calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // set the tab bar item with a title and both images
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Events" image:defaultImage selectedImage:selectedImage];
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Special Events Countdown";
    self.eventsTableView.allowsMultipleSelectionDuringEditing = NO;
    
    self.eventDatePicker.minimumDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];;
    
    self.eventsTableView.dataSource = self;
    self.eventsTableView.delegate = self;
    self.eventNameField.delegate = self;
    self.eventsArray = [[NSMutableArray alloc] init];
    
    NSDate *now = [NSDate date];
    
    SpecialEvent *halloween = [[SpecialEvent alloc]init];
    SpecialEvent *thanksgiving = [[SpecialEvent alloc]init];
    SpecialEvent *christmas = [[SpecialEvent alloc]init];
    SpecialEvent *newYears = [[SpecialEvent alloc]init];
    
    halloween.name = @"Halloween";
    thanksgiving.name = @"Thanksgiving";
    christmas.name = @"Christmas";
    newYears.name = @"New Years";
    
    
    NSDateFormatter* halloweenFormatter = [[NSDateFormatter alloc]init];
    [halloweenFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *halloweenDate = [halloweenFormatter dateFromString:@"2015-10-31"];
    halloween.time = [halloweenDate timeIntervalSinceDate:now];
    [self.eventsArray addObject:halloween];
    
    NSDateFormatter* thanksgivingFormatter = [[NSDateFormatter alloc]init];
    [thanksgivingFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *thanksgivingDate = [halloweenFormatter dateFromString:@"2015-11-26"];
    thanksgiving.time = [thanksgivingDate timeIntervalSinceDate:now];
     [self.eventsArray addObject:thanksgiving];
    
    NSDateFormatter* christmasFormatter = [[NSDateFormatter alloc]init];
    [christmasFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *christmasDate = [halloweenFormatter dateFromString:@"2015-12-25"];
    christmas.time = [christmasDate timeIntervalSinceDate:now];
     [self.eventsArray addObject:christmas];
    
    NSDateFormatter* newYearFormatter = [[NSDateFormatter alloc]init];
    [newYearFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *newYearDate = [halloweenFormatter dateFromString:@"2016-01-01"];
    newYears.time = [newYearDate timeIntervalSinceDate:now];
     [self.eventsArray addObject:newYears];
    
    
    
    [self setUpEventsTimer];
    
    
}
-(NSString*)timeFormattedWithValue:(double)value  {
    
    double time = value;
    int DD = time/86400;
    time = time - (86400 * DD);
    int hours = 3600;
    
    
    
    
    
    int HH = time / hours;
    
    
    time = time - (3600 * HH);
    int MM = time / 60;
    time = time - 60 * MM;
    int SS = floor(time);
    
    
    
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d:%.2d", DD, HH, MM, SS];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialEventCell" forIndexPath:indexPath];
    
    SpecialEvent *eventForCell = self.eventsArray[indexPath.row];
    cell.textLabel.text = eventForCell.name;
    cell.detailTextLabel.text = [self timeFormattedWithValue:eventForCell.time];
    
    if (indexPath.row>=[self.eventsArray count]-4) {
        [cell.textLabel setTextColor:[UIColor colorWithRed:80.0f/255.0f green:170.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    }
    else{
        [cell.textLabel setTextColor:[UIColor redColor]];
    }

    
    return cell;
}

-(void)setUpEventsTimer{
    self.eventsTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireEventsTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.eventsTimer forMode:NSRunLoopCommonModes];
}
-(void)fireEventsTimer {
    for (SpecialEvent* event in self.eventsArray) {
        event.time --;
    }
    [self.eventsTableView reloadData];
    
    
}
- (IBAction)addEvent:(id)sender {
    
    if ([self.eventNameField.text isEqualToString:@""]) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please select a name" message:@"You must select a name for your event." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        SpecialEvent *newEvent = [[SpecialEvent alloc]init ];
        NSDate* now = [NSDate date];
        newEvent.time = [self.eventDatePicker.date timeIntervalSinceDate:now];
        newEvent.name = self.eventNameField.text;
        
        
        [self.eventsArray insertObject:newEvent atIndex:0];
        [self.eventNameField resignFirstResponder];
        [self.eventsTableView reloadData];

    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.eventNameField resignFirstResponder];
    return YES;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    NSLog(@"%lu",indexPath.row);
    if ([self.eventsArray count]-4 > indexPath.row ) {
        
        return YES;
    }
    
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.eventsArray removeObjectAtIndex:indexPath.row];
        [self.eventsTableView reloadData];
        //[self.presetArrayOfDictionaries ]
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MemoViewController *memoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MemoViewController"];
    memoVC.event = self.eventsArray[indexPath.row];
    
    [self.navigationController pushViewController:memoVC animated:YES];
}

@end
