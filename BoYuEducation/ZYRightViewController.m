//
//  ZYRightViewController.m
//  BoYuEducation
//
//  Created by Wei on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYRightViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ZYRightViewController ()

@end

@implementation ZYRightViewController

//@synthesize superView = _superView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)addPanGesture
{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handelPan:)];
    [self.view addGestureRecognizer:panGes];
    [panGes release];
}

- (void)handelPan: (UIPanGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _beginPoint = [gestureRecognizer locationInView:self.view];
    }
    CGPoint curPoint = [gestureRecognizer locationInView:self.view];
    CGRect frame = self.view.frame;
    frame.origin.x += curPoint.x - _beginPoint.x;
//    frame.origin.y += curPoint.y - _beginPoint.y;
    [self.view setFrame:frame];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
