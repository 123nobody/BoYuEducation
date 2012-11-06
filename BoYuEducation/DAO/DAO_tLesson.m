//
//  DAO_tLesson.m
//  BoYuEducation
//
//  Created by Wei on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DAO_tLesson.h"

@implementation DAO_tLesson

- (NSInteger)numberOfLessonsWithTraindayId: (NSInteger)traindayid
{
    DAO_tTrain *trainDAO = [[DAO_tTrain alloc]init];
    int trainid = [trainDAO selectTrainId];
    [trainDAO release];
    NSString *sql = [NSString stringWithFormat:@"select count(lessonName) as count from t_lesson where trainid = %d and traindayid = %d", trainid, traindayid];
    
    NSInteger count;
    [self.db open];
    FMResultSet *rs = [self.db executeQuery:sql];
    if (rs.columnCount == 0) {
        NSLog(@"Lesson count is 0!");
    }
    while ([rs next]) {
        count = [rs intForColumn:@"count"];
    }
    [rs close];
    [self.db close];

    return count;
}

- (NSString *)nameOfLessonsWithIndexPath: (NSIndexPath *)indexPath
{
    NSString *name = nil;
    
    DAO_tTrain *trainDAO = [[DAO_tTrain alloc]init];
    int trainid = [trainDAO selectTrainId];
    [trainDAO release];
    
    DAO_tTrainday *traindayDAO = [[DAO_tTrainday alloc]init];
    NSArray *traindayIds = [traindayDAO selectDayIds];
    [traindayDAO release];
    
    NSNumber *number = (NSNumber *)[traindayIds objectAtIndex:indexPath.section];
    int traindayid = [number intValue];
    [number release];
    
     NSString *sql = [NSString stringWithFormat:@"select lessonName from t_lesson where trainid = %d and traindayid = %d", trainid, traindayid];
    
    NSMutableArray *lessonNames = [[NSMutableArray alloc]init];
    
    [self.db open];
    FMResultSet *rs = [self.db executeQuery:sql];
    if (rs.columnCount == 0) {
        NSLog(@"lessonNames is nil!");
    }
    while ([rs next]) {
        [lessonNames addObject:[rs stringForColumn:@"lessonName"]];
    }
    [rs close];
    [self.db close];
    
    name = [lessonNames objectAtIndex:indexPath.row];
    [lessonNames release];
    
    return name;
}

@end
