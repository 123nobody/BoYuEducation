//
//  ZYAppView.m
//  BoYuEducation
//
//  Created by Wei on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYAppView.h"

@implementation ZYAppView

@synthesize image = _image;
@synthesize button = _button;
@synthesize name = _name;


- (id)initWithImage:(UIImage *)image Name:(NSString *)name
{
    CGRect frame;
    
    frame = CGRectMake(0, 0, BY_APP_IMAGE_WIDTH, (BY_APP_IMAGE_HEIGHT + BY_APP_PADDING_OF_IMAGE_AND_NAME));
    self = [super initWithFrame:frame];
    if (self) {
        
        _image = [[UIImageView alloc]initWithImage:image];
        frame = CGRectMake(0, 0, BY_APP_IMAGE_WIDTH, BY_APP_IMAGE_HEIGHT);
        [_image setFrame:frame];
        _image.backgroundColor = [UIColor brownColor];
//        [self addSubview:_image];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:frame];
        [_button setBackgroundImage:image forState:UIControlStateNormal];
        [self addSubview:_button];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(0, (BY_APP_IMAGE_HEIGHT + BY_APP_PADDING_OF_IMAGE_AND_NAME), BY_APP_NAME_WIDTH, BY_APP_NAME_HEIGHT)];
        _name.backgroundColor = [UIColor yellowColor];
        _name.text = name;
        _name.textAlignment = UITextAlignmentCenter;
        [self addSubview:_name];
        
//        self.backgroundColor = [UIColor lightGrayColor];
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
