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
    CGRect frame = CGRectMake((BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT), 0, BY_CENTERVIEW_WIDTH, BY_CENTERVIEW_HEIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        //设置圆角
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        
        _contentView = [self getContentView];
        [self addSubview:_contentView];
        _leftShadowView = [self getLeftShadowView];
        [self addSubview:_leftShadowView];
        _rightShadowView = [self getRightShadowView];
        [self addSubview:_rightShadowView];
//        _topView = [self getTopView];
//        [self addSubview:_topView];
//        _tableView = [self getTableView];
//        [self addSubview:_tableView];
//        _bottomView = [self getBottomView];
//        [self addSubview:_bottomView];
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

- (UITableView *)getTableView
{
    UITableView *tableView;
    CGRect frame = CGRectMake(0, BY_CENTERVIEW_TOP_HEIGHT, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), (BY_CENTERVIEW_HEIGHT - BY_CENTERVIEW_TOP_HEIGHT - BY_CENTERVIEW_BOTTOM_HEIGHT));
    tableView = [[[UITableView alloc]initWithFrame:frame]autorelease];
    
    return tableView;
}

- (UIView *)getContentView
{
    UIView *contentView;
    CGRect frame = CGRectMake(BY_CENTERVIEW_SHADOW_WIDTH, 0, (BY_CENTERVIEW_WIDTH - BY_CENTERVIEW_SHADOW_WIDTH * 2), BY_CENTERVIEW_HEIGHT);
    contentView = [[[UIView alloc]initWithFrame:frame]autorelease];
    
    //设置圆角
    contentView.layer.cornerRadius = 6;
    contentView.layer.masksToBounds = YES;
    
    _topView = [self getTopView];
    [contentView addSubview:_topView];
    _tableView = [self getTableView];
    [contentView addSubview:[self getTableView]];
    _bottomView = [self getBottomView];
    [contentView addSubview:[self getBottomView]];
    
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
    _beginPoint = [[touches anyObject] locationInView:self];
    if (_beginPoint.x > 0 && _beginPoint.x < self.frame.size.width) {
        //记录第一个点，以便计算移动距离
        self.tag = 1;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.tag == 1) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        // 计算移动距离，并更新图像的frame
        CGRect frame = self.frame;
        frame.origin.x += pt.x - _beginPoint.x;
        //    frame.origin.y += pt.y - _beginPoint.y;
        [self setFrame:frame]; 
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.tag == 1) {
        CGRect frame = self.frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        if (self.frame.origin.x >= 150) {
            frame.origin.x = BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_OVER_LENGHT;
            [self setFrame:frame];
            [_delegate didMoveCenterViewToDirection:@"right"];
        } else {
            frame.origin.x = BY_MENUVIEW_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_MOVE_LENGHT - BY_CENTERVIEW_OVER_LENGHT;
            [self setFrame:frame];
            [_delegate didMoveCenterViewToDirection:@"left"];
        }
        [UIView commitAnimations];
        self.tag = 0;
    }        
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
