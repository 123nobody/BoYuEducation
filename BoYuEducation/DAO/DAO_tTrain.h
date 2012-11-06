//
//  DAO_tTrain.h
//  BoYuEducation
//
//  Created by Wei on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseDao.h"
#import "Model_tTrain.h"

@interface DAO_tTrain : BaseDao

- (Model_tTrain *)selectTrain;

- (NSInteger)selectTrainId;
- (NSString *)selectTrainName;

@end
