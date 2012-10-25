//
//  ZYViewController.h
//  BoYuEducation
//
//  Created by Wei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYAppView.h"
#import "ZYGridView.h"

@interface ZYViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
    UITableView *_menuTable;
    NSArray *_cellContents;
    
    UIView *_centerView;
    UIView *_backView;
    ZYGridView *_gridView;
    
    CGPoint _beginPoint;
    
    NSMutableArray *_cellTabViews;
}

@property(nonatomic, strong) UITableView *menuTable;
@property(nonatomic, strong) NSArray *cellContents;
@property(nonatomic, strong) NSMutableArray *cellTabViews;
@property(nonatomic, strong) UIView *centerView;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIView *gridView;

@end
