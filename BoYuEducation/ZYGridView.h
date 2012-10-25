//
//  ZYGridView.h
//  BoYuEducation
//
//  Created by Wei on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//小应用水平垂直间距
#define BY_GRIDVIEW_HORIZONTAL_PADDING 30
#define BY_GRIDVIEW_VERTICAL_PADDING 30

@interface ZYGridView : UIView
{
    BOOL _isInitStatic;
}

@property (assign, nonatomic) BOOL isInitStatic;

- (id)initWithZYAppViews:(NSArray *)appViews;

@end
