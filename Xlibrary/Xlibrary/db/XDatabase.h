//
//  XDatabase.h
//  Xlibrary
//
//  Created by mc on 15/4/23.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "XPIModel.h"




@interface XDatabase : NSObject


@property(nonatomic,strong)FMDatabaseQueue* GeebooQueue;


+(id)shareInstance;

-(void)insertPIDataWithModel:(XPIModel*)xpimodel;

-(void)updateUserInformationWithModel:(XPIModel*)xpimodel;

- (NSMutableArray *)getDataarrayFrome:(NSString*)begindate toEnd:(NSString*)enddate;

- (NSArray *)getDataFromType:(NSString *)typeStr withSItype:(NSString *)IStype;

- (NSMutableArray *)getDataFromDay:(NSString *)day withMouth:(NSString *)mouth withyear:(NSString *)year withType:(NSString *)type withTimeType:(NSString *)timeTypes;

-(void)deleteData:(XPIModel*)model;

-(NSArray *)getDataFormTime:(NSDate *)date withType:(NSString *)type;
@end
