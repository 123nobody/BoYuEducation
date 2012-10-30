//
//  ZYViewController.m
//  BoYuEducation
//
//  Created by Wei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYViewController.h"

@interface ZYViewController ()

@end

@implementation ZYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"load example view, frame: %@", NSStringFromCGRect(self.view.frame));
    _skinId = 0;
    
    UIView *logoView = [[UIView alloc]initWithFrame:CGRectMake(25, 15, 164, 60)];
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    logoView.backgroundColor = [UIColor colorWithPatternImage:logoImage];
    [self.view addSubview:logoView];
    [logoView release];
    
    [self changeSkinId:_skinId];
    
    _menuView = [[ZYMenuView alloc]init];
    _menuView.delegate = self;
    [self.view addSubview:_menuView];
    
    [self initBackView];
    //初始化centerView
    _centerView = [[ZYCenterView alloc]initWithMenuCellIndex:0];
    //添加拖动手势
    [_centerView addPanGesture];
    _centerView.delegate = self;
    [self.view addSubview:_centerView];
    
    return;
}

- (void)initRightViewWithView: (UIView *)view
{
    if (_rightViewController == nil) {
        _rightViewController = [[ZYRightViewController alloc]init];
        _rightViewController.delegate = self;
    }
    
//    [_rightViewController putOut];
    
    _rightViewController.putInFrame = view.frame;
    _rightViewController.view = view;
    
    [_rightViewController.view setFrame:CGRectMake(1524, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    [_rightViewController addPanGesture];
    [self.view addSubview:_rightViewController.view];
//    [_rightViewController putIn];
}

//初始化backView
- (void)initBackView
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH + BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_OVER_LENGHT), 0, (1024 - BY_MENUVIEW_MARGIN_LEFT - BY_MENUCELL_WIDTH - BY_CENTERVIEW_WIDTH + BY_CENTERVIEW_OVER_LENGHT), 748)];
    _backView.exclusiveTouch = YES;
    
    NSMutableArray *appViewsArray = [[NSMutableArray alloc]init];
    
    UIImage *image_1 = [[UIImage imageNamed:@"button_01.png"]autorelease];
    ZYAppView *appView_1 = [[ZYAppView alloc]initWithImage:image_1 Name:@"营销工具"];
    [appViewsArray addObject:appView_1];
    [appView_1 release];
    
    UIImage *image_2 = [[UIImage imageNamed:@"button_02.png"]autorelease];
    ZYAppView *appView_2 = [[ZYAppView alloc]initWithImage:image_2 Name:@"金融产品"];
    [appViewsArray addObject:appView_2];
    [appView_2 release];
    
    UIImage *image_3 = [[UIImage imageNamed:@"button_03.png"]autorelease];
    ZYAppView *appView_3 = [[ZYAppView alloc]initWithImage:image_3 Name:@"计算器"];
    [appViewsArray addObject:appView_3];
    [appView_3 release];
    
    UIImage *image_4 = [[UIImage imageNamed:@"button_04.png"]autorelease];
    ZYAppView *appView_4 = [[ZYAppView alloc]initWithImage:image_4 Name:@"更换皮肤"];
    [appViewsArray addObject:appView_4];
    [appView_4 release];
    
    UIImage *image_5 = [[UIImage imageNamed:@"button_plus.png"]autorelease];
    ZYAppView *appView_5 = [[ZYAppView alloc]initWithImage:image_5 Name:@""];
    [appViewsArray addObject:appView_5];
    [appView_5 release];
    
    _gridView = [[ZYGridView alloc]initWithZYAppViews:appViewsArray];
    [appViewsArray release];
    _gridView.delegate = self;
    _gridView.exclusiveTouch = YES;
    
    //水平对齐
    CGRect backViewFrame = _backView.frame;
    CGRect gridViewFrame = _gridView.frame;
    gridViewFrame = CGRectMake(((backViewFrame.size.width - gridViewFrame.size.width) / 2), gridViewFrame.origin.y, gridViewFrame.size.width, gridViewFrame.size.height);
    [_gridView setFrame:gridViewFrame];
    
    //向右滑动关闭窗口
    UIImage *closeImage = [UIImage imageNamed:@"close.png"];
    UIView *hintImageView = [[UIView alloc]initWithFrame:CGRectMake(40, 450, closeImage.size.width, closeImage.size.height)];
    hintImageView.backgroundColor = [UIColor colorWithPatternImage:closeImage];
    [_gridView addSubview:hintImageView];
    [hintImageView release];
    
    [_backView addSubview:_gridView];
    [self.view addSubview:_backView];
}

//backView适配动画
- (void)doBackViewAnimationWithRecognizerDirection: (UISwipeGestureRecognizerDirection)recognizerDirection
{
    CGRect centerViewFrame = _centerView.frame;
    CGRect backViewFrame = _backView.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    if (recognizerDirection == UISwipeGestureRecognizerDirectionLeft && _gridView.isInitStatic == YES) {
        backViewFrame = CGRectMake((centerViewFrame.origin.x + centerViewFrame.size.width), backViewFrame.origin.y, backViewFrame.size.width + BY_CENTERVIEW_MOVE_LENGHT, backViewFrame.size.height);
        _gridView.isInitStatic = NO;
    } else if (recognizerDirection == UISwipeGestureRecognizerDirectionRight && _gridView.isInitStatic == NO) {
        backViewFrame = CGRectMake((centerViewFrame.origin.x + centerViewFrame.size.width), backViewFrame.origin.y, backViewFrame.size.width - BY_CENTERVIEW_MOVE_LENGHT, backViewFrame.size.height);
        _gridView.isInitStatic = YES;
    }
    
    [_backView setFrame:backViewFrame];
    [UIView commitAnimations];
    NSLog(@"move backView.");
    
    //水平对齐gridView
    CGRect gridViewFrame = _gridView.frame;
    gridViewFrame = CGRectMake(((backViewFrame.size.width - gridViewFrame.size.width) / 2), gridViewFrame.origin.y, gridViewFrame.size.width, gridViewFrame.size.height);
    
    //动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_gridView setFrame:gridViewFrame];
    [UIView commitAnimations];
    
}

- (void)didMoveCenterViewToDirection:(NSString *)direction
{
    if ([direction isEqualToString:@"left"]) {
        [self doBackViewAnimationWithRecognizerDirection:UISwipeGestureRecognizerDirectionLeft];
    } else {
        [self doBackViewAnimationWithRecognizerDirection:UISwipeGestureRecognizerDirectionRight];
    }
}

- (void)centerTableView:(ZYCenterTableView *)centerTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rightViewFrame;
    UIView *headerView;
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeButtonImage;
    
    NSLog(@"ZYView press button section:%d, row:%d", indexPath.section, indexPath.row);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 300, 300, 100)];
    
    switch (_menuView.currentCellIndex) {
        case 0:
        {
            label.text = [NSString stringWithFormat:@"菜单1 group：%d row:%d", indexPath.section, indexPath.row];
            rightViewFrame = CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT - BY_CENTERVIEW_MOVE_LENGHT + BY_CENTERVIEW_WIDTH - 10), 0, 470, 748);
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightViewFrame.size.width, 60)];
            headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_br.png"]];
            
            closeButtonImage = [UIImage imageNamed:@"button-close2.png"];                                         
        }
            break;
            
        case 1:
        {
            label.text = [NSString stringWithFormat:@"菜单2 group：%d row:%d", indexPath.section, indexPath.row];
            rightViewFrame = CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT - BY_CENTERVIEW_MOVE_LENGHT + 60), 0, 850, 748);
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightViewFrame.size.width, 60)];
            headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_br.png"]];
            
            closeButtonImage = [UIImage imageNamed:@"button-close2.png"];
        }
            break;
            
        case 2:
        {
            label.text = [NSString stringWithFormat:@"菜单3 group：%d row:%d", indexPath.section, indexPath.row];
            rightViewFrame = CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT - BY_CENTERVIEW_MOVE_LENGHT + 60), 0, 850, 748);
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightViewFrame.size.width, 60)];
            headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_br.png"]];
            
            closeButtonImage = [UIImage imageNamed:@"button-close2.png"];
        }
            break;
            
            
        case 3:
        {
            label.text = [NSString stringWithFormat:@"菜单4 group：%d row:%d", indexPath.section, indexPath.row];
            rightViewFrame = CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT - BY_CENTERVIEW_MOVE_LENGHT + BY_CENTERVIEW_WIDTH - 10), 0, 470, 748);
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightViewFrame.size.width, 60)];
            headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_br.png"]];
            
            closeButtonImage = [UIImage imageNamed:@"button-close2.png"];
        }
            break;
            
        default:
            break;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:rightViewFrame];
    view.backgroundColor = [UIColor lightGrayColor];
    //设置圆角
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    
    [closeButton setFrame:CGRectMake((headerView.frame.size.width - 50), ((headerView.frame.size.height - closeButtonImage.size.height - 8) / 2), closeButtonImage.size.width, closeButtonImage.size.height)];
    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(pressCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"addTarget!!!!!!");
    [headerView addSubview:closeButton];
    [view addSubview:headerView];
    [view addSubview:label];
    
    [headerView release];
    [label release];
    if (!(_rightViewController == nil)) {
        [_rightViewController putOutWithChecking:NO];
    }
    [self initRightViewWithView:view];
    [_rightViewController putIn];
    [view release];
}

- (void)ZYRightViewPutIn
{
    _centerView.isLocked = YES;
}

- (void)ZYRightViewPutOut
{
    _centerView.isLocked = NO;
}

//关闭rightView
- (void)pressCloseButton:sender
{
    NSLog(@"gggggggggggggg");
    [_rightViewController putOutWithChecking:NO];
}

//ZYAppView代理
- (void)pressButton:(NSString *)buttonName
{
    NSLog(@"press button %@", buttonName);
    if ([buttonName isEqualToString:@"更换皮肤"]) {
        [self changeSkinId:++_skinId];
    }
}

//更换皮肤
- (void)changeSkinId: (NSInteger)skinId
{
    NSArray *skinNameArray = [[NSArray alloc]initWithObjects:
                              @"background_01.png", 
                              @"background_02.png", 
                              @"background_03.png", 
                              @"background_04.png", 
                              @"background_05.png", nil];
    
    // 准备动画
    CATransition *animation = [CATransition animation];
    //动画播放持续时间
    [animation setDuration:0.5f];
    //动画速度,何时快、慢
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionFade];
    [self.view.layer addAnimation:animation forKey:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[skinNameArray objectAtIndex:(skinId % skinNameArray.count)]]];
    // 结束动画
    [UIView commitAnimations];
}

//menuView代理
- (void)didSelectMenuCellAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"00000000000000");
        }
            break;
            
        case 1:
        {
            NSLog(@"11111111111111");
        }
            break;
            
        case 2:
        {
            NSLog(@"22222222222222");
        }
            break;
            
        default:
            break;
    }
    
    //切换centerView内容
    [_centerView changeContentViewWithMenuIndex:index];
    [_rightViewController putOutWithChecking:NO]; 
}

- (void)ZYMenuView:(UIView *)menuView PressSetupButton:(UIButton *)setupButton
{
    ZYSettingViewController *settingViewController = [[ZYSettingViewController alloc]init];
    
    [settingViewController.view setFrame:CGRectMake(0.f, 0.f, 600.f, 556.f)];
    
    settingViewController.modalPresentationStyle = UIModalPresentationFormSheet;//有三种状态，自己看看是哪种
    [self presentModalViewController:settingViewController animated:YES];
    settingViewController.view.superview.frame = CGRectMake(0.f, 0.f, 600.f, 600.f);//it's important to do this after 
    settingViewController.view.superview.center = CGPointMake(512, 384);
    
    return;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [_menuView release];
    [_menuView dealloc];
    [_cellContents release];
//    [_cellContents dealloc];
    [_cellTabViews release];
//    [_cellTabViews dealloc];
    [_centerView release];
    [_centerView dealloc];
    [_backView release];
//    [_backView dealloc];
    [_gridView release];
//    [_gridView dealloc];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
