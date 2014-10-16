//
//  ViewController.m
//  Plate Board
//
//  Created by prom phanit on 6/12/14.
//  Copyright (c) 2014 promphanit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *strokes;
//@property (nonatomic,strong) NSMutableArray *copyStr;
@property (nonatomic,strong) NSMutableArray *addStrokes;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 5.0;
    opacity = 1.0;
    self.strokes = [NSMutableArray array];
    self.addStrokes = [NSMutableArray array];
    //self.copyStr = [NSMutableArray array];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {

        startPoint = [recognizer locationInView:self.view];
        [self addBrushStrokeAtPoint:startPoint];
       // NSLog(@"start");
        
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"change");

        CGPoint currentPoint = [recognizer locationInView:self.view];
        [self addBrushStrokeAtPoint:currentPoint];
        UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-44));
        
        [self.drawingImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), startPoint.x, startPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        [self.drawingImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
        self.drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.drawingImageView setAlpha:opacity];
        UIGraphicsEndImageContext();
        
        startPoint = currentPoint;
        
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.addStrokes addObject:self.strokes];
        self.strokes = [NSMutableArray array];
        
    }

}

- (IBAction)clearBarButtonItem:(UIBarButtonItem *)sender {
    self.drawingImageView.image = nil;
    [self.strokes removeAllObjects];
    [self.addStrokes removeAllObjects];
    
}

-(void)redrawingAnimation{

    for (int i=0; i < self.addStrokes.count; i++) {
        
        self.strokes = [NSMutableArray array];
        [self.strokes addObjectsFromArray:self.addStrokes[i]];
        NSValue *valueStart = self.strokes[0];
        CGPoint pointStart = [valueStart CGPointValue];
        
        for (int j=1; j<[self.addStrokes[i] count]; j++) {

            NSValue *valueCurrent = self.strokes[j];
            CGPoint pointCurrent = [valueCurrent CGPointValue];
            
            UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-44));
            
            [self.drawingImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pointStart.x, pointStart.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), pointCurrent.x, pointCurrent.y);
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
            
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            [self.drawingImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
            self.drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            [self.drawingImageView setAlpha:opacity];
            UIGraphicsEndImageContext();
            pointStart = pointCurrent;
            [self performSelector:@selector(redrawingAnimation) withObject:nil afterDelay:1.0];
        }
        
    }
    
}

-(void)counter{
    NSLog(@"cout");
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SettingViewController *svc = segue.destinationViewController;
    svc.delegate = self;
    svc.brush = brush;
    svc.opacity = opacity;
    svc.red = red;
    svc.green = green;
    svc.blue = blue;
}

-(void)doneSettings:(UIViewController *)sender{
    SettingViewController *senderObj = (SettingViewController *)sender;
    
    brush = senderObj.brush;
    opacity = senderObj.opacity;
    red = senderObj.red;
    green = senderObj.green;
    blue = senderObj.blue;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point
{

    [self.strokes addObject:[NSValue valueWithCGPoint:point]];

}

- (IBAction)animate:(UIBarButtonItem *)sender {
    
    self.drawingImageView.image = nil;
    [self redrawingAnimation];
    //[self performSelector:@selector(redrawingAnimation) withObject:nil afterDelay:2.0];


    
}

@end
