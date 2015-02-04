//
//  ViewController.m
//  sweetRoll
//
//  Created by Dmitry Shlyugaev on 03.02.15.
//  Copyright (c) 2015 glitterofhyad. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
    NSMutableArray* _gamersPickerData;
    NSMutableArray* _commandPickerData;
    NSMutableArray* _gamersToCommand;
}

@property (strong, nonatomic) IBOutlet UIPickerView *gamersPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *commandPicker;
@property (strong, nonatomic) IBOutlet UIButton *runBtn;

@end

@implementation ViewController

int lengthOfGamers = 30;
int lengthOfCommand = 15;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gamersPickerData = [[NSMutableArray alloc] init];
    _commandPickerData = [[NSMutableArray alloc] init];
    _gamersToCommand = [[NSMutableArray alloc] init];
    
    for(int i=2; i <  lengthOfGamers; i++) {
        [_gamersPickerData addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for(int i=2; i <  lengthOfCommand; i++) {
        [_commandPickerData addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.gamersPicker.dataSource = self;
    self.gamersPicker.delegate = self;
    self.commandPicker.dataSource = self;
    self.commandPicker.delegate = self;
    
    _runBtn.layer.borderWidth=1.0f;
    _runBtn.layer.borderColor=[[UIColor blackColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == self.gamersPicker) {
        return _gamersPickerData.count;
    }
    else if(pickerView == self.commandPicker) {
        return _commandPickerData.count;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // Some stuff
    
    // Assuming "yourDataArray" contains your strings
    //selectedString = [yourDataArray objectAtIndex:row];
    
    NSLog(@"select %@", [_gamersPickerData objectAtIndex:row]);
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(150.0f, 0.0f, 170.0f, 60.0f)];
    label.font = [label.font fontWithSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    
    
    if(pickerView == self.gamersPicker) {
        label.text = [_gamersPickerData objectAtIndex:row];
    }
    else if(pickerView == self.commandPicker) {
        label.text = [_commandPickerData objectAtIndex:row];
    }
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.0f;
}

- (IBAction)runSort:(id)sender {
}

@end
