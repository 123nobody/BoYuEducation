//
//  ZYDataCache.h
//  BoYuEducation
//
//  Created by Wei on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseDao.h"
#import "DAO_tTrain.h"

@interface ZYDataCache : BaseDao
{
    NSMutableDictionary *_menu_1_Dic;
    NSMutableArray *_menu_2_Array;
    NSMutableArray *_menu_3_Array;
    NSMutableArray *_menu_4_Array;
}

@property (nonatomic, strong) NSMutableDictionary *menu_1_Dic;
@property (nonatomic, strong) NSMutableArray *menu_2_Array;
@property (nonatomic, strong) NSMutableArray *menu_3_Array;
@property (nonatomic, strong) NSMutableArray *menu_4_Array;


- (NSMutableDictionary *)getMenu_1_Dic;

@end
