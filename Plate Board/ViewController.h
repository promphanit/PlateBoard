//
//  ViewController.h
//  Plate Board
//
//  Created by prom phanit on 6/12/14.
//  Copyright (c) 2014 promphanit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate> {
    CGPoint startPoint;
    CGFloat brush;
    CGFloat opacity;
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *drawingImageView;

- (IBAction)clearBarButtonItem:(UIBarButtonItem *)sender;


@end
