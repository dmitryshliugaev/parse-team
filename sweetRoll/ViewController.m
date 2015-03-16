//
//  ViewController.m
//  sweetRoll
//
//  Created by Dmitry Shlyugaev on 03.02.15.
//  Copyright (c) 2015 glitterofhyad. All rights reserved.
//

#import "ViewController.h"
#import "numbersForGamersViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <stdlib.h>

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
int lengthOfCommand = 3;
int gamers = 2;
int command = 2;

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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == self.gamersPicker) {
        gamers = [[_gamersPickerData objectAtIndex:row] intValue];
        [_commandPickerData removeAllObjects];
        for(int i=2; i <  gamers+1; i++) {
            [_commandPickerData addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [self.commandPicker reloadAllComponents];
    }
    else if(pickerView == self.commandPicker) {
        command = [[_gamersPickerData objectAtIndex:row] intValue];
    }
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
    
    int fullGamersOnCommand = gamers/command;
    int restOfPlayers = gamers%command;
    [_gamersToCommand removeAllObjects];
    
    NSMutableArray* numGamersToCommand = [[NSMutableArray alloc] init];
    
    if(gamers<command) {
        return;
    }
    
    for(int i=0; i < command; i++) {
        [_gamersToCommand addObject:[[NSMutableArray alloc] init]];
    }

    for(int i=0; i < (gamers-restOfPlayers); i++) {
        int commanToGamer = arc4random_uniform(command);
        
        NSMutableArray* commandPoint = [_gamersToCommand objectAtIndex:commanToGamer];
        if([commandPoint count] < fullGamersOnCommand) {
            [commandPoint addObject:[NSString stringWithFormat:@"%d", i+1]];
            [numGamersToCommand addObject:[NSString stringWithFormat:@"%d", commanToGamer+1]];
        }else {
            i--;
        }
        
    }
    
    if(restOfPlayers!=0) {
        for (int i = (gamers-restOfPlayers), j=0; i < gamers; i++, j++) {
            if([_gamersToCommand count]<j) {
                j=0;
            }
            [[_gamersToCommand objectAtIndex:j] addObject:[NSString stringWithFormat:@"%d", i+1]];
            [numGamersToCommand addObject:[NSString stringWithFormat:@"%d", j+1]];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:numGamersToCommand forKey:@"gamersToCommand"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    numbersForGamersViewController *numbersForGamersView = [self.storyboard instantiateViewControllerWithIdentifier:@"numbersForGamers"];
    [self.navigationController pushViewController:numbersForGamersView animated:YES];
}

@end
