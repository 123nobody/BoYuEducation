//
//  ZYMenuView.m
//  BoYuEducation
//
//  Created by Wei on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYMenuView.h"

@implementation ZYMenuView

- (id)init
{
    _cellArray = [[NSArray alloc]initWithObjects:@"title_1.png", @"title_2.png", @"title_3.png", nil];
    _currentCellIndex = 0;
    
    CGRect frame = CGRectMake(BY_MENUVIEW_MARGIN_LEFT, BY_MENUVIEW_MARGIN_TOP, BY_MENUCELL_WIDTH + BY_MENUCELL_MARGIN_LEFT, (BY_MENUCELL_HEIGHT * _cellArray.count + BY_MENUCELL_MARGIN_TOP * (_cellArray.count - 1)));
    
    self = [super initWithFrame:frame];
    if (self) {
        UIControl *cellView;
        for (int i = 0; i < _cellArray.count; i++) {
            CGFloat x, y, width, height;
            x = BY_MENUCELL_MARGIN_LEFT;
            //如果是第一个按钮，默认选中，左移。
            if (i == 0) {
                x -= BY_MENUCELL_MOVE_LENGHT;
            }
            y = (BY_MENUCELL_MARGIN_TOP * i + BY_MENUCELL_HEIGHT * i);
            width = BY_MENUCELL_WIDTH;
            height = BY_MENUCELL_HEIGHT;
            cellView = [[UIControl alloc]initWithFrame:CGRectMake(x, y, width, height)];
            cellView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[_cellArray objectAtIndex:i]]];
            cellView.tag = i;
            
            [cellView addTarget:self action:@selector(pressMenuCell:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:cellView];
            [cellView release];
        }
        
        
    }
    return self;
}

- (void)pressMenuCell:sender
{
    UIView *view = (UIView *)sender;
    if (view.tag == _currentCellIndex) {
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect frame;
    
    frame = view.frame;
    frame.origin.x -= BY_MENUCELL_MOVE_LENGHT;
    [view setFrame:frame];
    
    UIView *currentView = [[self subviews] objectAtIndex:_currentCellIndex];
    frame = currentView.frame;
    frame.origin.x += BY_MENUCELL_MOVE_LENGHT;
    [currentView setFrame:frame];
    
    [UIView commitAnimations];
    
    switch (view.tag) {
        case 0:
        {
            NSLog(@"press cell index %d do something.", view.tag);
        }
            break;
            
        default:
            break;
    }
    _currentCellIndex = view.tag;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
