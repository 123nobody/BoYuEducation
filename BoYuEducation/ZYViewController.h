//
//  ZYViewController.h
//  BoYuEducation
//
//  Created by Wei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYMenuView.h"
#import "ZYCenterView.h"
#import "ZYAppView.h"
#import "ZYGridView.h"

@interface ZYViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ZYGridViewDelegate, ZYCenterViewDelegate> 
{
    NSArray *_cellContents;
    
    ZYMenuView *_menuView;
    ZYCenterView *_centerView;
    UIView *_backView;
    ZYGridView *_gridView;
    
    CGPoint _beginPoint;
    
    NSMutableArray *_cellTabViews;
    
    NSInteger _skinId;
}

@property(nonatomic, strong) NSArray *cellContents;
@property(nonatomic, strong) NSMutableArray *cellTabViews;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIView *gridView;

@end
