//
//  SettingViewController.h
//  Plate Board
//
//  Created by prom phanit on 6/12/14.
//  Copyright (c) 2014 promphanit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>
- (void)doneSettings:(UIViewController *)sender;
@end

@interface SettingViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *pickColor;

@property (weak, nonatomic) IBOutlet UISlider *brushSlider;
@property (weak, nonatomic) IBOutlet UISlider *opacitySlider;
@property (weak, nonatomic) IBOutlet UILabel *brushLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityLabel;

@property (weak, nonatomic) id<SettingsViewControllerDelegate> delegate;

@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

- (IBAction)sliderChanged:(UISlider *)sender;

@end
