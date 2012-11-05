//
//  Model_tLesson.h
//  BoYuEducation
//
//  Created by Wei on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_tLesson : NSObject
{
    int _id;
    
    int _trainid;
    int _traindayid;
    NSString *_lessonName;
    NSString *_lessonTime;
    int _teacherid;
    
    NSString *_modifyTime;
    int _isDelete;
}

@property (nonatomic, assign) int _id;

@property (nonatomic, assign) int trainid;
@property (nonatomic, assign) int traindayid;
@property (nonatomic, strong) NSString *lessonName;
@property (nonatomic, strong) NSString *lessonTime;
@property (nonatomic, assign) int teacherid;

@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, assign) int isDelete;

@end
