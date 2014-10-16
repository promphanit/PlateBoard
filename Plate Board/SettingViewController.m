//
//  SettingViewController.m
//  Plate Board
//
//  Created by prom phanit on 6/12/14.
//  Copyright (c) 2014 promphanit. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property NSArray *colorName;
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.colorName count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.colorName[row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UIColor *color;
    switch (row) {
        case 0:
            color = [UIColor redColor];
            self.red = 1.0;
            self.green = 0.0;
            self.blue =0.0;
            break;
            
        case 1:
            color = [UIColor greenColor];
            self.red = 0.0;
            self.green = 1.0;
            self.blue =0.0;
            break;
            
        case 2:
            color = [UIColor blueColor];
            self.red = 0.0;
            self.green = 0.0;
            self.blue =1.0;
            break;
            
        case 3:
            color = [UIColor blackColor];
            self.red = 0.0;
            self.green = 0.0;
            self.blue =0.0;
            break;

    }
    [self.pickColor setBackgroundColor:color];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.colorName = @[@"Red",@"Green",@"Blue",@"Black"];
    self.brushSlider.value = self.brush;
    [self sliderChanged:self.brushSlider];
    
    self.opacitySlider.value = self.opacity;
    [self sliderChanged:self.opacitySlider];
    
    [self.pickColor setBackgroundColor:[UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:1.0]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender {
    
    [self.delegate doneSettings:self];

}



- (IBAction)sliderChanged:(UISlider *)sender {
    if (sender == self.brushSlider) {
        self.brush = self.brushSlider.value;
        self.brushLabel.text = [NSString stringWithFormat:@"%.1f",self.brush];
    }
    else if(sender == self.opacitySlider){
        self.opacity = self.opacitySlider.value;
        self.opacityLabel.text = [NSString stringWithFormat:@"%.1f",self.opacity];
    }
    
    
}
@end
