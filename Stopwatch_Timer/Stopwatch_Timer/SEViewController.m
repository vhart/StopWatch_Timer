//
//  SEViewController.m
//  Stopwatch_Timer
//
//  Created by Jackie Meggesto on 8/27/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "SEViewController.h"


@interface SEViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *eventsArray;
@property (nonatomic) NSTimer* eventsTimer;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;


@end

@implementation SEViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.eventsTableView.dataSource = self;
    self.eventsTableView.delegate = self;
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
    
    
    
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d:%d", DD, HH, MM, SS];
    
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
    
    SpecialEvent *newEvent = [[SpecialEvent alloc]init ];
    NSDate* now = [NSDate date];
    newEvent.time = [self.eventDatePicker.date timeIntervalSinceDate:now];
    newEvent.name = self.eventNameField.text;
    [self.eventsArray addObject:newEvent];
    [self.eventsTableView reloadData];
}




@end
