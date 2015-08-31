//
//  AddPresetTimerViewController.m
//  Stopwatch_Timer
//
//  Created by Varindra Hart on 8/29/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "AddPresetTimerViewController.h"

@interface AddPresetTimerViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *timerNameTextfield;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic) NSString *timeString;

@end

@implementation AddPresetTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    self.timerNameTextfield.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addButtonTapped:(UIButton *)sender {
    
    [self.timerNameTextfield resignFirstResponder];
    
    if (self.timerNameTextfield.text == nil || [self.timerNameTextfield.text isEqualToString: @""]) {
        [self showAlert:@"Don't forget to add a timer name"];
        return;
    }
    
    
    BOOL validDate = [self readDatePicker];
    
    if (validDate) {
        

        [self.delegate newPresetWithName:self.timerNameTextfield.text timeString:self.timeString];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    
}

- (void)showAlert:(NSString *)error{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Almost there!" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (BOOL) readDatePicker{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"k:mm"];
    self.timeString = [outputFormatter stringFromDate:self.datePicker.date];
    if ([self.timeString isEqualToString:@"24:00"]) {
        [self showAlert:@"Time cannot be 0 hours 0 seconds"];
        return NO;
    }
    
    return YES;
    
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
