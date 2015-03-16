//
//  numbersForGamersViewController.m
//  sweetRoll
//
//  Created by Dmitry Shlyugaev on 04.02.15.
//  Copyright (c) 2015 glitterofhyad. All rights reserved.
//

#import "numbersForGamersViewController.h"

@interface numbersForGamersViewController () {
    NSMutableArray* _gamersToCommand;
    NSMutableArray* _colors;
}
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UIButton *next;
@property (strong, nonatomic) IBOutlet UIView *numView;
@property (strong, nonatomic) IBOutlet UILabel *totalNumbers;

@end

@implementation numbersForGamersViewController

int numberIndex = 0;
int numColorIndex = 0;

-(void)viewDidLoad {
    [super viewDidLoad];
    numberIndex = 0;
    _gamersToCommand = [[NSUserDefaults standardUserDefaults] valueForKey:@"gamersToCommand"];
    _number.text = [_gamersToCommand objectAtIndex:numberIndex];
    numberIndex = 1;
    _next.layer.borderWidth = 1.0f;
    _next.layer.borderColor = [[UIColor blackColor] CGColor];
    
    _colors = [[NSMutableArray alloc] init];
    
    [_colors addObject:[UIColor colorWithRed:(230/255.0) green:(126/255.0) blue:(34/255.0) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:(52/255.0) green:(152/255.0) blue:(219/255.0) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:(231/255.0) green:(76/255.0) blue:(60/255.0) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:(26/255.0) green:(188/255.0) blue:(156/255.0) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:(155/255.0) green:(89/255.0) blue:(182/255.0) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:(46/255.0) green:(206/255.0) blue:(113/255.0) alpha:1]];
}

-(void)viewDidAppear:(BOOL)animated {
    numberIndex = 0;
    _gamersToCommand = [[NSUserDefaults standardUserDefaults] valueForKey:@"gamersToCommand"];
    _number.text = [_gamersToCommand objectAtIndex:numberIndex];
    numberIndex = 1;
}

- (IBAction)next:(id)sender {
    if(numberIndex == 50) {
        [_next setTitle:@"Next" forState:UIControlStateHighlighted];
        [_next setTitle:@"Next" forState:UIControlStateNormal];
        _totalNumbers.text = @"";
        numberIndex = 0;
    }
    if(numberIndex>=[_gamersToCommand count]) {
        numberIndex = 50;
        [_next setTitle:@"Repeat" forState:UIControlStateHighlighted];
        [_next setTitle:@"Repeat" forState:UIControlStateNormal];
        [_number setText:@" "];
        
        _totalNumbers.text = [_gamersToCommand componentsJoinedByString:@", "];
        _numView.backgroundColor = [UIColor whiteColor];
    }
    if(numberIndex<[_gamersToCommand count]) {
        [_number setText:[_gamersToCommand objectAtIndex:numberIndex]];
        [_number setAlpha:0.0];
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
                         {
                             [_number setAlpha:1.0];
                         }
                         completion:^(BOOL finished){}];
        numberIndex++;
        if(numColorIndex == [_colors count]) {
            numColorIndex = 0;
        }
        _numView.backgroundColor = [_colors objectAtIndex:numColorIndex];
        numColorIndex++;
        
    }
}

@end
