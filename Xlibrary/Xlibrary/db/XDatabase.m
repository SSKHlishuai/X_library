//
//  XDatabase.m
//  Xlibrary
//
//  Created by mc on 15/4/23.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "XDatabase.h"

@implementation XDatabase


#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

#define GeebooDB @"GB.db"

static XDatabase *dbConnection;

+(id)shareInstance
{
    if(!dbConnection)
    {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            dbConnection = [[XDatabase alloc]init];
        });
    }
    return dbConnection;
}
-(id)init{
    self=[super init];
    if (self) {
        // accountId = [UserInfor getInstanceUser].accountId;
        self.GeebooQueue= [FMDatabaseQueue databaseQueueWithPath:[self documentsDirectoryWithFileName:GeebooDB]];

    }
    
    return self;
}
-(NSArray *)getDataFormTime:(NSDate *)date withType:(NSString *)type{
    NSString *day = [NSString day:date];
    NSString *mouth = [NSString month:date];
    NSString *year = [NSString year:date];
    NSString *timeTypes = [NSString stringWithFormat:@"%d",CYCLE_NONE];
    NSMutableArray *dateArry = [self getDataFromDay:day withMouth:mouth withyear:year withType:type withTimeType:timeTypes];
    NSArray *typeArry = [self getDataFromType:[NSString stringWithFormat:@"%d",CYCLE_EVERYDAY]withSItype:type];
    if (typeArry){
        for (XPIModel *model in typeArry){
            [dateArry addObject:model];
        }
    }

    
    if ([[NSString day:date] isEqualToString:@"1"]){
        timeTypes = [NSString stringWithFormat:@"%d",CYCLE_EVERYMOUTH];
        typeArry = [self getDataFromType:[NSString stringWithFormat:@"%d",CYCLE_EVERYMOUTH]withSItype:type];
        if (typeArry){
            for (XPIModel *model in typeArry){
                [dateArry addObject:model];
            }
        }
    }
    if ([[NSString week:date] isEqualToString:@"1"]){
        timeTypes = [NSString stringWithFormat:@"%d",CYCLE_EVERYWEEK];
        typeArry = [self getDataFromType:[NSString stringWithFormat:@"%d",CYCLE_EVERYWEEK]withSItype:type];
        if (typeArry){
            for (XPIModel *model in typeArry){
                [dateArry addObject:model];
            }
        }

    }
    return dateArry;
    
}
-(NSString*)documentsDirectoryWithFileName:(NSString*)fileName
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *directoryString = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return directoryString;
}


#pragma mark public

//添加数据
-(void)insertPIDataWithModel:(XPIModel *)xpimodel
{
    [self.GeebooQueue inDatabase:^(FMDatabase * db){
        [db beginTransaction];
        [db executeUpdate:@"insert into maintable (createtime,cyear,cmonth,cday,typestr,spendcount,describe,type,spendorincome) values(?,?,?,?,?,?,?,?,?)",xpimodel.createtime,xpimodel.cyear,xpimodel.cmonth,xpimodel.cday,xpimodel.typestr,xpimodel.spendcount,xpimodel.describe,xpimodel.type,xpimodel.spendorincome];
        FMDBQuickCheck(![db hadError]);
        [db commit];
    }];

}

//更新数据内容
-(void)updateUserInformationWithModel:(XPIModel*)xpimodel
{
    NSString *sqlOne;
    sqlOne = [NSString stringWithFormat:@"update maintable set typestr = '%@',spendcount = '%@', describe = '%@',type = '%@',spendincome = '%@' where createtime = '%@'",xpimodel.typestr,xpimodel.spendcount,xpimodel.describe,xpimodel.type,xpimodel.spendorincome,xpimodel.createtime];
    [self.GeebooQueue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:sqlOne];
        FMDBQuickCheck(![db hadError]);
        NSLog(@"更新用户信息");
        [db commit];
    }];
    
}

//获得一个时间范围内的数据
- (NSMutableArray *)getDataarrayFrome:(NSString*)begindate toEnd:(NSString*)enddate
{
    NSString *sql = [NSString stringWithFormat:@"select * from maintable where createtime > '%@' and createtime < '%@' and type = '%@'",begindate,enddate,[NSString stringWithFormat:@"%d",CYCLE_NONE]];
    NSMutableArray *registArr =[[NSMutableArray alloc]init];
    
    [self.GeebooQueue inDatabase:^(FMDatabase*db){
        FMResultSet* set=[db executeQuery:sql];
        while ([set next]) {
            
            XPIModel *model = [[XPIModel alloc]init];
            model.createtime =[set stringForColumn:@"createtime"];
            model.cyear = [set stringForColumn:@"cyear"];
            model.cmonth = [set stringForColumn:@"cmonth"];
            model.cday = [set stringForColumn:@"cday"];
            model.typestr = [set stringForColumn:@"typestr"];
            model.spendcount = [set stringForColumn:@"spendcount"];
            model.describe = [set stringForColumn:@"describe"];
            model.type = [set stringForColumn:@"type"];
            model.spendorincome = [set stringForColumn:@"spendorincome"];
            
            [registArr addObject:model];
        }
        
    }];
    
    
    return registArr;
    
}
- (NSMutableArray *)getDataFromDay:(NSString *)day withMouth:(NSString *)mouth withyear:(NSString *)year withType:(NSString *)type withTimeType:(NSString *)timeTypes{
    NSString *sql = [NSString stringWithFormat:@"select * from maintable where cday = '%@' and cmonth = '%@' and cyear = '%@' and spendorincome = '%@' and type = '%@'",day,mouth,year,type,timeTypes];
    NSLog(@"%@",sql);
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    [self.GeebooQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            XPIModel *model = [[XPIModel alloc]init];
            model.createtime =[set stringForColumn:@"createtime"];
            model.cyear = [set stringForColumn:@"cyear"];
            model.cmonth = [set stringForColumn:@"cmonth"];
            model.cday = [set stringForColumn:@"cday"];
            model.typestr = [set stringForColumn:@"typestr"];
            model.spendcount = [set stringForColumn:@"spendcount"];
            model.describe = [set stringForColumn:@"describe"];
            model.type = [set stringForColumn:@"type"];
            model.spendorincome = [set stringForColumn:@"spendorincome"];
            [resultArr addObject:model];
        }
    }];
    return resultArr;
    
}

- (NSArray *)getDataFromType:(NSString *)typeStr withSItype:(NSString *)IStype{
    NSString *sql = [NSString stringWithFormat:@"select * from maintable where type = '%@' and spendorincome = '%@'",typeStr,IStype];
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    [self.GeebooQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            
            NSDictionary *dict = [set resultDictionary];
            XPIModel *model = [[XPIModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
//            model.createtime =[set stringForColumn:@"createtime"];
//            model.cyear = [set stringForColumn:@"cyear"];
//            model.cmonth = [set stringForColumn:@"cmonth"];
//            model.cday = [set stringForColumn:@"cday"];
//            model.typestr = [set stringForColumn:@"typestr"];
//            model.spendcount = [set stringForColumn:@"spendcount"];
//            model.describe = [set stringForColumn:@"describe"];
//            model.type = [set stringForColumn:@"type"];
//            model.spendorincome = [set stringForColumn:@"spendorincome"];
            [resultArr addObject:model];
        }
    }];
    return resultArr;
    
}

//删除某条数据
-(void)deleteData:(XPIModel*)model
{
    [self.GeebooQueue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:@"DELETE FROM maintable where createtime = ?",model.createtime];
        FMDBQuickCheck(![db hadError]);
        LOG_ME_DEBUG(@"清除当前用户所有消息");
        [db commit];
    }];
}












@end
