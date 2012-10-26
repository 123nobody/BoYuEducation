//
//  ZYViewController.m
//  BoYuEducation
//
//  Created by Wei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ZYViewController ()

@end

@implementation ZYViewController

@synthesize cellContents = _cellContents;
@synthesize cellTabViews = _cellTabViews;
@synthesize backView = _backView;
@synthesize gridView = _gridView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"load example view, frame: %@", NSStringFromCGRect(self.view.frame));
    _skinId = 0;
    
    UIView *logoView = [[UIView alloc]initWithFrame:CGRectMake(25, 15, 164, 60)];
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    logoView.backgroundColor = [UIColor colorWithPatternImage:logoImage];
    [self.view addSubview:logoView];
    [logoView release];
    
    [self changeSkinId:_skinId];
    
    
    _menuView = [[ZYMenuView alloc]init];
    [self.view addSubview:_menuView];
    
    [self initBackView];
    
    _centerView = [[ZYCenterView alloc]init];
    [self.view addSubview:_centerView];
    
//    [self initMenuTableView];
//    [self initCenterView];
    

    return;
}

////初始化menuTableView
//- (void)initMenuTableView
//{
//    _cellTabViews = [[NSMutableArray alloc]init];
//    
//    _cellContents = [[NSArray alloc]initWithObjects:@"", @"     培训课程", @"     在线调查", @"     在线考试", nil];
//    
//    _menuView = [[UITableView alloc]initWithFrame:CGRectMake(BY_MENUVIEW_MARGIN_LEFT, BY_MENUVIEW_MARGIN_TOP, BY_MENUCELL_WIDTH, (BY_MENUCELL_HEIGHT * (_cellContents.count - 1) + BY_MENUCELL_TAB_HEIGHT)) style:UITableViewStylePlain];
////    _menuView.delegate = self;
////    _menuView.dataSource = self;
//    _menuView.exclusiveTouch = YES;
////    _menuView.scrollEnabled = NO;
//    //清除UITableView分割线
////    _menuView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
////    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
////    [_menuView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
////    NSLog(@"begin select %d", [_menuView indexPathForSelectedRow].row);
//    
////    UIView *view =[ [UIView alloc]init];
////    view.backgroundColor = [UIColor clearColor];
////    [_menuView setTableFooterView:view];
////    [view release];
//    
//    _menuView.backgroundColor = [UIColor clearColor];
//    
//    [self.view addSubview:_menuView];
//}

////初始化centerView
//- (void)initCenterView
//{
//    _centerView = [[UIView alloc]initWithFrame:CGRectMake((BY_menuView_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT), 0, 450, 748)];
//    _centerView.backgroundColor = [UIColor greenColor];
//    _centerView.exclusiveTouch = YES;
//    
//    [self.view addSubview:_centerView];
//    
//}

//初始化backView
- (void)initBackView
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH + BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_OVER_LENGHT), 0, (1024 - BY_MENUVIEW_MARGIN_LEFT - BY_MENUCELL_WIDTH - BY_CENTERVIEW_WIDTH + BY_CENTERVIEW_OVER_LENGHT), 748)];
    _backView.exclusiveTouch = YES;
//    _backView.backgroundColor = [UIColor darkGrayColor];
    
    NSMutableArray *appViewsArray = [[NSMutableArray alloc]init];
    
    UIImage *image_1 = [[UIImage imageNamed:@"button_01.png"]autorelease];
    ZYAppView *appView_1 = [[[ZYAppView alloc]initWithImage:image_1 Name:@"营销工具"]autorelease];
    [appViewsArray addObject:appView_1];
    
    UIImage *image_2 = [[UIImage imageNamed:@"button_02.png"]autorelease];
    ZYAppView *appView_2 = [[[ZYAppView alloc]initWithImage:image_2 Name:@"金融产品"]autorelease];
    [appViewsArray addObject:appView_2];
    
    UIImage *image_3 = [[UIImage imageNamed:@"button_03.png"]autorelease];
    ZYAppView *appView_3 = [[[ZYAppView alloc]initWithImage:image_3 Name:@"计算器"]autorelease];
    [appViewsArray addObject:appView_3];
    
    UIImage *image_4 = [[UIImage imageNamed:@"button_04.png"]autorelease];
    ZYAppView *appView_4 = [[[ZYAppView alloc]initWithImage:image_4 Name:@"更换皮肤"]autorelease];
    [appViewsArray addObject:appView_4];
    
    UIImage *image_5 = [[UIImage imageNamed:@"button_plus.png"]autorelease];
    ZYAppView *appView_5 = [[[ZYAppView alloc]initWithImage:image_5 Name:@""]autorelease];
    [appViewsArray addObject:appView_5];
    
    _gridView = [[ZYGridView alloc]initWithZYAppViews:appViewsArray];
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
    
    
//    [image release];
//    [appView release];
    
    [self.view addSubview:_backView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _beginPoint = [[touches anyObject] locationInView:_centerView];
    if (_beginPoint.x > 0 && _beginPoint.x < _centerView.frame.size.width) {
        //记录第一个点，以便计算移动距离
        _centerView.tag = 1;
        NSLog(@"1111111");
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_centerView.tag == 1) {
        CGPoint pt = [[touches anyObject] locationInView:_centerView];
        // 计算移动距离，并更新图像的frame
        CGRect frame = _centerView.frame;
        frame.origin.x += pt.x - _beginPoint.x;
        //    frame.origin.y += pt.y - _beginPoint.y;
        [_centerView setFrame:frame]; 
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_centerView.tag == 1) {
        CGRect frame = _centerView.frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        if (_centerView.frame.origin.x >= 150) {
            frame.origin.x = BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT;
            [_centerView setFrame:frame];
            [self doBackViewAnimationWithRecognizerDirection:UISwipeGestureRecognizerDirectionRight];
        } else {
            frame.origin.x = BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_MOVE_LENGHT - BY_CENTERVIEW_OVER_LENGHT;
            [_centerView setFrame:frame];
            [self doBackViewAnimationWithRecognizerDirection:UISwipeGestureRecognizerDirectionLeft];
        }
        
        [UIView commitAnimations];
        _centerView.tag = 0;
    }        
}

//centerView手势识别
//- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer 
//{
//    switch (recognizer.direction) {
//        case UISwipeGestureRecognizerDirectionLeft:
//        {
//            NSLog(@"left");
//            //移动centerView
//            [self doCenterViewAnimationWithRecognizer:recognizer];
//        }
//            break;
//            
//        case UISwipeGestureRecognizerDirectionRight:
//        {
//            NSLog(@"right");
//            [self doCenterViewAnimationWithRecognizer:recognizer];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    // 底下是刪除手势的方法
//    //[self.view removeGestureRecognizer:recognizer];
//}

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

//centerView动画
- (void)doCenterViewAnimationWithRecognizer: (UISwipeGestureRecognizer *)recognizer
{
    //动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = _centerView.frame;
    NSLog(@"frame:%@", NSStringFromCGRect(frame));
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft && frame.origin.x == 200) {
        frame.origin.x -= 100;
        [_centerView setFrame:frame];
//        [self doBackViewAnimationWithRecognizer:recognizer];
        NSLog(@"do left");
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight && frame.origin.x == 100) {
        frame.origin.x += 100;
        [_centerView setFrame:frame];
//        [self doBackViewAnimationWithRecognizer:recognizer];
        NSLog(@"do right");
    }
    
    //执行动画
    [UIView commitAnimations];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (index == 0) {
        [_cellTabViews addObject:[[UIView alloc]init]];
        return cell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_cellContents objectAtIndex:index];
    
    CGRect frame;
    NSString *titleImageName;
    
//    frame = cell.textLabel.frame;
//    frame.size.width += BY_MENUCELL_MOVE_LENGHT;
//    [cell.textLabel setFrame:frame];
    
    if (_cellTabViews.count < _cellContents.count) {
        frame = CGRectMake(0, (BY_MENUCELL_HEIGHT * (index - 1)), BY_MENUCELL_TAB_WIDTH, BY_MENUCELL_TAB_HEIGHT);
        UIView *tabView = [[UIView alloc]initWithFrame:frame];
        titleImageName = [[NSString alloc]initWithFormat:@"title_%da.png", index];
        tabView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:titleImageName]];
        
//        cell.textLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:titleImageName]];
        
        [_cellTabViews addObject:tabView];
        
        
        [_menuView addSubview:tabView];
        
        [tabView release];

    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BY_MENUCELL_WIDTH, BY_MENUCELL_HEIGHT)];
    titleImageName = [NSString stringWithFormat:@"title_%db.png", index];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:titleImageName]];
//    NSLog(@"titleImageName:%@", titleImageName);
    [cell addSubview:view];
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return BY_MENUCELL_TAB_HEIGHT;
    }
    return BY_MENUCELL_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellContents.count;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    }
    NSLog(@"will Select Row %d", [tableView indexPathForSelectedRow].row);
    if ([tableView indexPathForSelectedRow].row == indexPath.row) {
        NSLog(@"This row is selecting.");
        return indexPath;
    }
    NSLog(@"selected row %d.", indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.frame = CGRectMake(0, 0, (BY_MENUCELL_WIDTH + BY_MENUCELL_MOVE_LENGHT), BY_MENUCELL_HEIGHT);
//    cell.textLabel.backgroundColor = [UIColor redColor];
    
    //动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame;
    
    frame = cell.frame;
    frame.origin.x -= BY_MENUCELL_MOVE_LENGHT;
    [cell setFrame:frame];
    
    UIView *cellTabView = (UIView *)[_cellTabViews objectAtIndex:indexPath.row];
    frame = cellTabView.frame;
    frame.origin.x -= BY_MENUCELL_MOVE_LENGHT;
    [cellTabView setFrame:frame];
    //执行动画
    [UIView commitAnimations];
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deselected row %d.", indexPath.row);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [tableView cellForRowAtIndexPath:indexPath].textLabel.backgroundColor = [UIColor lightGrayColor];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = cell.frame;
    frame.origin.x += BY_MENUCELL_MOVE_LENGHT;
    [cell setFrame:frame];
    
    UIView *cellTabView = (UIView *)[_cellTabViews objectAtIndex:indexPath.row];
    CGRect cellTabFrame = cellTabView.frame;
    cellTabFrame.origin.x += BY_MENUCELL_MOVE_LENGHT;
    [cellTabView setFrame:cellTabFrame];
    
    [UIView commitAnimations];
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
    /*动画效果
     kCATransitionFade      淡出
     kCATransitionMoveIn    覆盖原图
     kCATransitionPush      推出
     kCATransitionReveal    底部显出来
     */
    [animation setType:kCATransitionFade];
    [self.view.layer addAnimation:animation forKey:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[skinNameArray objectAtIndex:(skinId % skinNameArray.count)]]];
    // 结束动画
    [UIView commitAnimations];
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
