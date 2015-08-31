//
//  MemoViewController.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/31/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "MemoViewController.h"

@interface MemoViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic) IBOutlet UITableView * eventsTableView;
@property (nonatomic, weak) IBOutlet UITextField * textField;
@property (weak, nonatomic) IBOutlet UIButton *AddButton;

@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.delegate = self;
    self.eventsTableView.delegate = self;
    self.eventsTableView.dataSource = self;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Memos",self.event.name];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.event.memos == nil) {
        self.event.memos = [NSMutableArray new];
    };
    
    return [self.event.memos count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoCellIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.event.memos[indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //
}

- (IBAction)addEventButton:(UIButton *)sender{
    if (self.textField.text.length == 0) {
        return;
    }
    else{
    [self.event.memos addObject:[NSString stringWithFormat:@"%@",self.textField.text]];
    self.textField.text = @"";
        [self.eventsTableView reloadData];
    
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    [self addEventButton:self.AddButton];
    return YES;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.event.memos removeObjectAtIndex:indexPath.row];
        [self.eventsTableView reloadData];
        //[self.presetArrayOfDictionaries ]
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
