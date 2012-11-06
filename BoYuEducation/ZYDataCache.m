//
//  ZYDataCache.m
//  BoYuEducation
//
//  Created by Wei on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYDataCache.h"

@implementation ZYDataCache

@synthesize menu_1_Dic = _menu_1_Dic;
@synthesize menu_2_Array = _menu_2_Array;
@synthesize menu_3_Array = _menu_3_Array;
@synthesize menu_4_Array = _menu_4_Array;

- (id)init
{
    self = [super init];
    if (self) {
//        _menu_1_Dic = [[NSMutableDictionary alloc]init];
//        _menu_2_Array = [[NSMutableArray alloc]init];
//        _menu_3_Array = [[NSMutableArray alloc]init];
//        _menu_4_Array = [[NSMutableArray alloc]init];
        
        self.menu_1_Dic = [self getMenu_1_Dic];
    }
    
    return self;
}

- (NSMutableDictionary *)getMenu_1_Dic
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]init]autorelease];
    
    //取得培训id
    DAO_tTrain *trainDAO = [[DAO_tTrain alloc]init];
    int trainId = [trainDAO selectTrainId];
    [trainDAO release];
    
    [self.db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT d.id, l.lessonName FROM t_trainday d left outer join t_lesson l ON d.id = l.traindayid WHERE d.trainid = %d ORDER BY d.id,l.id", trainId];
    NSLog(@"sql = %@", sql);
    FMResultSet *rs = [self.db executeQuery:sql];
    if (rs.columnCount == 0) {
        NSLog(@"getMenu_1_Dic is nil!");
    }
    NSString *key = nil;
    NSString *title = nil;
    NSMutableArray *titleArray;
    while ([rs next]) {
        key = [NSString stringWithFormat:@"%d", [rs intForColumn:@"ID"]];
        if ([dic objectForKey:key]) {
            titleArray = [dic objectForKey:key];
            title = [rs stringForColumn:@"lessonName"];
            [titleArray addObject:title];
        } else {
            title = [rs stringForColumn:@"lessonName"];
            titleArray = [[NSMutableArray alloc]initWithObjects:title, nil];
            [dic setObject:titleArray forKey:key];
        }
    }
    [rs close];
    [self.db close];
    
    return dic;
}

- (void)dealloc
{
    [_menu_1_Dic release];
    _menu_1_Dic = nil;
    [_menu_2_Array release];
    _menu_2_Array = nil;
    [_menu_3_Array release];
    _menu_3_Array = nil;
    [_menu_4_Array release];
    _menu_4_Array = nil;
    [super dealloc];
}

@end
