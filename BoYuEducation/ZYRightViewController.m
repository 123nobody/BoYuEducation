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

@synthesize delegate = _delegate;
@synthesize putInFrame = _putInFrame;
@synthesize isShow = _isShow;
@synthesize webView = _webView;

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
        _isMaxViewState = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (UIView *)getHeaderViewWithRightViewFrame: (CGRect)rightViewFrame MenuIndex: (NSInteger)index
{
    NSLog(@"getHeaderView");
    UIView *headerView;
    headerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, rightViewFrame.size.width, 60)]autorelease];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_br.png"]];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *closeButtonImage;
    closeButtonImage = [UIImage imageNamed:@"button-close2.png"];
    
    [closeButton setFrame:CGRectMake((headerView.frame.size.width - 50), ((headerView.frame.size.height - closeButtonImage.size.height - 8) / 2), closeButtonImage.size.width, closeButtonImage.size.height)];
    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(pressCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.tag = 1;
    [headerView addSubview:closeButton];
    
    if (index == 3) {
        UIButton *maxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *maxButtonImage;
        maxButtonImage = [UIImage imageNamed:@"narrow.png"];
        
        [maxButton setFrame:CGRectMake((headerView.frame.size.width - 90), ((headerView.frame.size.height - maxButtonImage.size.height - 8) / 2), maxButtonImage.size.width, maxButtonImage.size.height)];
        [maxButton setBackgroundImage:maxButtonImage forState:UIControlStateNormal];
        [maxButton addTarget:self action:@selector(pressMaxButton:) forControlEvents:UIControlEventTouchUpInside];
        maxButton.tag = 2;
        [headerView addSubview:maxButton];
    }
    
    switch (index) {
        case 0:
            ;
            break;
            
        case 1:
            ;
            break;
            
        case 2:
            ;
            break;
            
        case 3:
            ;
            break;
            
        default:
            break;
    }
    
    _headerView = headerView;
    return headerView;
}

//关闭rightView
- (void)pressCloseButton:sender
{
    NSLog(@"rightView dismiss!");
    _isMaxViewState = NO;
    [self putOutWithChecking:NO];
}

- (void)pressMaxButton:sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    if (_isMaxViewState) {
        [self.view setFrame:_putInFrame];
        [_headerView setFrame:CGRectMake(0, 0, _putInFrame.size.width, 60)];
        UIView *view;
        view = [_headerView viewWithTag:1];
        [view setFrame:CGRectMake((_headerView.frame.size.width - 50), ((_headerView.frame.size.height - view.frame.size.height - 8) / 2), view.frame.size.width, view.frame.size.height)];
        view = [_headerView viewWithTag:2];
        [view setFrame:CGRectMake((_headerView.frame.size.width - 90), ((_headerView.frame.size.height - view.frame.size.height - 8) / 2), view.frame.size.width, view.frame.size.height)];
        
        [_webView setFrame:CGRectMake(0, _headerView.frame.size.height, _putInFrame.size.width, (_putInFrame.size.height - _headerView.frame.size.height))];
    } else {
        [self.view setFrame:CGRectMake(0, 0, 1024, 748)];
        [_headerView setFrame:CGRectMake(0, 0, 1024, 60)];
        UIView *view;
        view = [_headerView viewWithTag:1];
        [view setFrame:CGRectMake((_headerView.frame.size.width - 50), ((_headerView.frame.size.height - view.frame.size.height - 8) / 2), view.frame.size.width, view.frame.size.height)];
        view = [_headerView viewWithTag:2];
        [view setFrame:CGRectMake((_headerView.frame.size.width - 90), ((_headerView.frame.size.height - view.frame.size.height - 8) / 2), view.frame.size.width, view.frame.size.height)];
        
        [_webView setFrame:CGRectMake(0, _headerView.frame.size.height, 1024, (_putInFrame.size.height - _headerView.frame.size.height))];
    }
    [UIView commitAnimations];
    _isMaxViewState = !_isMaxViewState;
}

//添加平移手势
- (void)addPanGesture
{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handelPan:)];
    [self.view addGestureRecognizer:panGes];
    [panGes release];
}

- (void)handelPan: (UIPanGestureRecognizer*)gestureRecognizer
{
    if (_isMaxViewState) {
        return;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _beginPoint = [gestureRecognizer locationInView:self.view];
    }
    CGPoint curPoint = [gestureRecognizer locationInView:self.view];
    CGFloat offset = curPoint.x - _beginPoint.x;
//    //偏移量小于0，为向左滑动，不允许
//    if (offset < 0) {
//        return;
//    }
    CGRect frame = self.view.frame;
    frame.origin.x += offset;
//    frame.origin.y += curPoint.y - _beginPoint.y;
    [self.view setFrame:frame];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //右移消失
        [self putOutWithChecking:YES];
    }
}

- (void)putIn
{
    if (_isShow) {
        return;
    }
    _isShow = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:_putInFrame];
    
    [UIView commitAnimations];
    [_delegate ZYRightViewPutIn];
}

//当点击菜单时，应强制putout
- (void)putOutWithChecking:(BOOL)checking
{
    if (!_isShow) {
        return;
    }
    CGRect frame = self.view.frame;
    if (checking && (frame.origin.x < (_putInFrame.origin.x + 50))) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
    
//        //变更
        frame.origin.x = _putInFrame.origin.x;
        [self.view setFrame:frame];
//        // 结束动画
        [UIView commitAnimations];
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    frame.origin.x = 1524;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
    // 准备动画
    CATransition *animation = [CATransition animation];
    //动画播放持续时间
    [animation setDuration:0.1f];
    //动画速度,何时快、慢
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    /*动画效果
     kCATransitionFade      淡出
     kCATransitionMoveIn    覆盖原图
     kCATransitionPush      推出
     kCATransitionReveal    底部显出来
     */
    [animation setType:kCATransitionFade];
    [self.view.layer addAnimation:animation forKey:nil];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    //变更
    [self.view setFrame:frame];
    
    // 结束动画
    [UIView commitAnimations];
    
    _isShow = NO;
    
    [_delegate ZYRightViewPutOut];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}
@end
