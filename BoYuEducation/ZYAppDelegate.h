//
//  ZYAppDelegate.h
//  BoYuEducation
//
//  Created by Wei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface ZYAppDelegate : UIResponder <UIApplicationDelegate>

{
    FMDatabase *_boyuDB;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FMDatabase *boyuDB;

@end
