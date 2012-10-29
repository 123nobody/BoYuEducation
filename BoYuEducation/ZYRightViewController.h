//
//  ZYRightViewController.h
//  BoYuEducation
//
//  Created by Wei on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BY_RIGHTVIEW_WIDTH_NORMAL 460.f
#define BY_RIGHTVIEW_HEIGHT 748.f


@protocol ZYRightViewControllerDelegate <NSObject>

- (void)ZYRightViewPutIn;
- (void)ZYRightViewPutOut;

@end

@interface ZYRightViewController : UIViewController
{
    id<ZYRightViewControllerDelegate> _delegate;
    CGPoint _beginPoint;
    CGRect _putInFrame;
    BOOL _isShow;//为了防止动画出现问题，所以不用isHidden。
}

//@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) id<ZYRightViewControllerDelegate> delegate;
@property (nonatomic, assign) CGRect putInFrame;
@property (nonatomic, assign) BOOL isShow;

- (void)addPanGesture;
- (void)putIn;
- (void)putOutWithChecking: (BOOL)checking;

@end
