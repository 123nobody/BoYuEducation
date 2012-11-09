//
//  DAO_tLesson.h
//  BoYuEducation
//
//  Created by Wei on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseDao.h"
#import "Model_tLesson.h"
#import "DAO_tAttch.h"
#import "DAO_tTeacher.h"
#import "DAO_tTrain.h"
#import "DAO_tTrainday.h"

@interface DAO_tLesson : BaseDao

- (NSInteger)numberOfLessonsWithTraindayId: (NSInteger)traindayid;
- (NSString *)nameOfLessonsWithIndexPath: (NSIndexPath *)indexPath;

- (Model_tLesson *)selectLessonModelByLessonId: (NSInteger)lessonId;
- (NSMutableArray *)selectLessonModelsByTraindayId: (NSInteger)traindayId;

@end
