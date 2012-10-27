//
//  ZYCenterView.m
//  BoYuEducation
//
//  Created by Wei on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYCenterView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZYCenterView

@synthesize delegate = _delegate;

- (id)init
{
    _currentViewIndex = 0;
    return [self initWithMenuCellIndex:_currentViewIndex];
}

- (id)initWithMenuCellIndex: (NSInteger)index
{
    CGRect frame = CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT), 0, BY_CENTERVIEW_WIDTH, BY_CENTERVIEW_HEIGHT);
    self = [super initWithFrame:frame];
    
    if (self) {
        //设置圆角
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        
        _currentViewIndex = index;
        
        _contentView = [self getContentViewWithMenuCellIndex:_currentViewIndex];
        [self addSubview:_contentView];
        _leftShadowView = [self getLeftShadowView];
        [self addSubview:_leftShadowView];
        _rightShadowView = [self getRightShadowView];
        [self addSubview:_rightShadowView];
    }
    
    return self;
}

- (UIView *)getTopView
{
    UIView *topView;
    UIImage *image;
    CGRect frame = CGRectMake(0, 0, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), BY_CENTERVIEW_TOP_HEIGHT);
    topView = [[[UIView alloc]initWithFrame:frame]autorelease];
    topView.exclusiveTouch = YES;
    image = [UIImage imageNamed:@"background01_top.png"];
    topView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIView *view;
    
    image = [UIImage imageNamed:@"course.png"];
    view = [[UIView alloc]initWithFrame:CGRectMake(20, ((BY_CENTERVIEW_TOP_HEIGHT - image.size.height) / 2), image.size.width, image.size.height)];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    [topView addSubview:view];
    [view release];
    
    
    return topView;
}

- (UIView *)getBottomView
{
    UIView *bottomView;
    CGRect frame = CGRectMake(0, (BY_CENTERVIEW_HEIGHT - BY_CENTERVIEW_BOTTOM_HEIGHT), (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), BY_CENTERVIEW_BOTTOM_HEIGHT);
    bottomView = [[[UIView alloc]initWithFrame:frame]autorelease];
    bottomView.exclusiveTouch = YES;
    bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background01_bottom.png"]];
    
    return bottomView;
}

- (ZYCenterTableView *)getTableView
{
//    UITableView *tableView;
    CGRect frame = CGRectMake(0, BY_CENTERVIEW_TOP_HEIGHT, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), (BY_CENTERVIEW_HEIGHT - BY_CENTERVIEW_TOP_HEIGHT - BY_CENTERVIEW_BOTTOM_HEIGHT));
//    tableView = [[[UITableView alloc]initWithFrame:frame]autorelease];
    
    ZYCenterTableView *tableView = [[[ZYCenterTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped]autorelease];
    tableView.touchDelegate = self;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *tmpView = [[[UIView alloc]init]autorelease];
    tmpView.backgroundColor = [UIColor whiteColor];
    tableView.backgroundView = tmpView;
    
//    _tableViewController = tableViewController;
//    [tableViewController release];
    
    return tableView;
}

- (UIView *)getContentViewWithMenuCellIndex: (NSInteger)index
{
    UIView *contentView;
    CGRect frame = CGRectMake(BY_CENTERVIEW_SHADOW_WIDTH, 0, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), BY_CENTERVIEW_HEIGHT);
    contentView = [[[UIView alloc]initWithFrame:frame]autorelease];
    contentView.backgroundColor = [UIColor whiteColor];
    
    //设置圆角
    contentView.layer.cornerRadius = 6;
    contentView.layer.masksToBounds = YES;
    
    switch (index) {
        case 0:
        {
            _topView = [self getTopView];
            [contentView addSubview:_topView];
            _tableView = [self getTableView];
            [contentView addSubview:_tableView];
            _bottomView = [self getBottomView];
            [contentView addSubview: _bottomView];
        }
            break;
            
        case 1:
        {
            _topView = [self getTopView];
            [contentView addSubview:_topView];
            _tableView = [self getTableView];
            [contentView addSubview:_tableView];
            _bottomView = [self getBottomView];
            [contentView addSubview: _bottomView];
        }
            break;
            
        case 2:
        {
            _topView = [self getTopView];
            [contentView addSubview:_topView];
            _tableView = [self getTableView];
            [contentView addSubview:_tableView];
            _bottomView = [self getBottomView];
            [contentView addSubview: _bottomView];
        }
            break;
            
        default:
            break;
    }
    
    return contentView;
}

- (UIView *)getLeftShadowView
{
    UIView *leftShadowView;
    CGRect frame = CGRectMake(0, 6, BY_CENTERVIEW_SHADOW_WIDTH, (BY_CENTERVIEW_HEIGHT - 6));
    leftShadowView = [[[UIView alloc]initWithFrame:frame]autorelease];
    leftShadowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background01_left.png"]];
    
    return leftShadowView;
}

- (UIView *)getRightShadowView
{
    UIView *rightShadowView;
    CGRect frame = CGRectMake((BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH), 6, BY_CENTERVIEW_SHADOW_WIDTH, (BY_CENTERVIEW_HEIGHT - 6));
    rightShadowView = [[[UIView alloc]initWithFrame:frame]autorelease];
    rightShadowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background01_right.png"]];
    
    return rightShadowView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"centerView touch began.");
    _beginPoint = [[touches anyObject] locationInView:self];
//    if (_beginPoint.x > 0 && _beginPoint.x < self.frame.size.width) {
        //记录第一个点，以便计算移动距离
        self.tag = 1;
//    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"centerView touch moved.");
//    if (self.tag == 1) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        // 计算移动距离，并更新图像的frame
        CGRect frame = self.frame;
        frame.origin.x += pt.x - _beginPoint.x;
        //    frame.origin.y += pt.y - _beginPoint.y;
        [self setFrame:frame]; 
        //设置tableView不可滚动、不可选中
        _tableView.scrollEnabled = NO;
        _tableView.allowsSelection = NO;
//    }
//    self.tag = 2;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"centerView touch ended.");
//    if (self.tag == 2) {
        if (self.frame.origin.x >= 150) {
            [self moveCenterViewToDirection:@"right"];
//            [_delegate didMoveCenterViewToDirection:@"right"];
            NSLog(@"doright!!!!!");
        } else {
            [self moveCenterViewToDirection:@"left"];
//            [_delegate didMoveCenterViewToDirection:@"left"];
            NSLog(@"doleft!!!!!");
        }
        
        self.tag = 0;
//    }        
}

- (void)moveCenterViewToDirection: (NSString *)direction
{
    //当tableView可选的时候，视为点击了cell，不移动它。
    if (_tableView.allowsSelection && (self.tag != 2)) {
        return;
    }
    CGRect frame = self.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    if ([direction isEqualToString:@"right"]) {
        frame.origin.x = BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT;
        [self setFrame:frame];
        [_delegate didMoveCenterViewToDirection:@"right"];
        NSLog(@"doright!!!!!123123");
    } else {
        frame.origin.x = BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_MOVE_LENGHT - BY_CENTERVIEW_OVER_LENGHT;
        [self setFrame:frame];
        [_delegate didMoveCenterViewToDirection:@"left"];
        NSLog(@"doleft!!!!!123123");
    }
    [UIView commitAnimations];
    _tableView.scrollEnabled = YES;
    _tableView.allowsSelection = YES;
}

- (void)ZYCenterTableViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"ZYCenterTableViewTouchesBegan");
    [self touchesBegan:touches withEvent:event];
}

- (void)ZYCenterTableViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"ZYCenterTableViewTouchesMoved");
    [self touchesMoved:touches withEvent:event];
}

- (void)ZYCenterTableViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"ZYCenterTableViewTouchesEnded");
    [self touchesEnded:touches withEvent:event];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //清除cell的背景边框
    UIView *tempView = [[[UIView alloc] init] autorelease];
    [cell setBackgroundView:tempView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect frame;
    UIView *view;
    UIImageView *imageView;
    UIImage *image;
    UILabel *label;
    
    frame = CGRectMake(0, 0, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), 20);
    view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    image = [UIImage imageNamed:@"icon01.png"];
    imageView = [[UIImageView alloc]initWithImage:image];
    frame = CGRectMake(20, 15, image.size.width, image.size.height);
    [imageView setFrame:frame];
    [view addSubview:imageView];
    [imageView release];
    
    frame = CGRectMake(45, 15, 300, 20);
    label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    
    switch (_currentViewIndex) {
        case 0:
        {
            label.text = @"金融理财概述和CFP制度";
        }
            break;
            
        case 1:
        {
            label.text = @"倾向时间价值与财务计算器操作";
        }
            break;
            
        case 2:
        {
            label.text = @"居住规划与房间投资";
        }
            break;
            
        default:
            break;
    }
    [view addSubview:label];
    [label release];
    
    [cell addSubview:view];
    [view release];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

//Section View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    CGRect frame;
    UILabel *label;
    
    frame = CGRectMake(0, 0, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), 40);
    headerView = [[[UIView alloc]initWithFrame:frame]autorelease];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background01_column.png"]];
    
    frame = CGRectMake(50, 10, 200, 20);
    label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"DATE 2012 10 25";
    [headerView addSubview:label];
    [label release];
    
    frame = CGRectMake(330, 10, 80, 20);
    label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"第一天";
    [headerView addSubview:label];
    [label release];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView;
    CGRect frame;
    
    frame = CGRectMake(0, 0, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), 12);
    footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background01_column2.png"]];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12.f;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will will");
    self.tag = 2;
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"press button section:%d, row:%d", indexPath.section, indexPath.row);
    [self moveCenterViewToDirection:@"left"];
//    [_delegate didMoveCenterViewToDirection:@"left"];
//    [_delegate centerTableView:(ZYCenterTableView *)tableView didDeselectRowAtIndexPath:indexPath];
}

- (void)changeContentViewWithMenuIndex:(NSInteger)index
{
    //移除view
//    [_topView removeFromSuperview];
//    [_tableView removeFromSuperview];
//    [_bottomView removeFromSuperview];
//    
//    _tableView  = [self getTableView];
    
    NSLog(@"changeContentView");
    CGRect frame;
    frame = self.frame;
    frame.origin.x = BY_CENTERVIEW_SHADOW_WIDTH;
    frame.size.width -= BY_CENTERVIEW_SHADOW_WIDTH * 2;
    UIView *tmpView = [[UIView alloc]initWithFrame:frame];
    tmpView.backgroundColor = [UIColor whiteColor];
    
    // 准备动画
    CATransition *animation = [CATransition animation];
    //动画播放持续时间
    [animation setDuration:0.5f];
    //动画速度,何时快、慢
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    /*动画效果
     kCATransitionFade      淡出
     kCATransitionMoveIn    覆盖原图
     kCATransitionPush      推出
     kCATransitionReveal    底部显出来
     */
    [animation setType:kCATransitionFade];
    [self.layer addAnimation:animation forKey:nil];
    
    //变更
//    [_contentView addSubview:_topView];
//    [_contentView addSubview:_tableView];
//    [_contentView addSubview:_bottomView];
    _currentViewIndex = index;
    [_tableView reloadData];
    
    // 结束动画
    [UIView commitAnimations];
    
//    [self easeOut];
}

- (void)easeOut
{
    NSLog(@"easeOut");
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
    [self.layer addAnimation:animation forKey:nil];
    
    //变更
    //    [self addSubview:tmpView];
    _topView = [self getTopView];
    [_contentView addSubview:_topView];
//    [self addSubview:_tableView];
//    [self addSubview:_bottomView];
    
    // 结束动画
    [UIView commitAnimations];
}

- (void)dealloc
{
    [_topView release];
    [_bottomView release];
    [_tableView release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
