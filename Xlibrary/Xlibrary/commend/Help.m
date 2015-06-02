//
//  Help.m
//  Xlibrary
//
//  Created by mc on 15/5/11.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "Help.h"

@implementation Help


+(NSInteger)getType:(NSString*)type
{
    NSInteger temp;
    if([type isEqualToString:@"无"])
    {
        temp = CYCLE_NONE;
    }
    else if([type isEqualToString:@"每日"])
    {
        temp = CYCLE_EVERYDAY;
    }
    else if([type isEqualToString:@"每周"])
    {
        temp = CYCLE_EVERYWEEK;
    }
    else
    {
        temp = CYCLE_EVERYMOUTH;
    }
    return temp;
}


+(NSString*)getImageName:(XPIModel*)model
{
    NSString *imageStr=@"";
    NSArray *dataArr = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]objectForKey:@"spend"];
    
    if(dataArr.count>0)
    {
        for(NSDictionary *everyDict in dataArr)
        {
            if([[everyDict objectForKey:@"typeTag"]isEqualToString:model.typestr])
            {
                imageStr = NSStringFormat([everyDict objectForKey:@"typeImage"]);
            }
        }

    }
    return imageStr;
    
}

+(NSString*)getTypeChineseName:(XPIModel*)model
{
    NSString *chineseStr=@"";
    NSArray *dataArr = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]objectForKey:@"spend"];
    
    if(dataArr.count>0)
    {
        for(NSDictionary *everyDict in dataArr)
        {
            if([[everyDict objectForKey:@"typeTag"]isEqualToString:model.typestr])
            {
                chineseStr = NSStringFormat([everyDict objectForKey:@"typeName"]);
            }
        }
        
    }
    return chineseStr;
    
}

+(NSInteger)getTotalMoney:(NSDate *)tempDate withISType:(NSString *)isType
{
    NSMutableArray *myArr = [NSMutableArray array];
    NSString *tempDay = [NSString day:tempDate];
    NSString *budgetFromDay = NSStringFormat([AppUserInfor getInstanceUser].budgetFrom);
    NSString *beginStr,*endStr;
    if([tempDay integerValue] >= [budgetFromDay integerValue])
    {
        beginStr = [NSString stringWithFormat:@"%@%02ld%02ld000000",[NSString year:tempDate],[[NSString month:tempDate]integerValue],[budgetFromDay integerValue]];
        
        if([[NSString month:tempDate]integerValue]==12)
        {
            endStr = [NSString stringWithFormat:@"%ld01%02ld000000",[[NSString year:tempDate] integerValue]+1,[budgetFromDay integerValue]];
        }
        else
        {
            endStr =[NSString stringWithFormat:@"%@%02ld%02ld000000",[NSString year:tempDate],[[NSString month:tempDate] integerValue]+1,[budgetFromDay integerValue]-1];
        }
        
        myArr= [[XDatabase shareInstance]getDataarrayFrome:beginStr toEnd:endStr];
    }
    else
    {
        endStr = [NSString stringWithFormat:@"%@%@%02ld000000",[NSString year:tempDate],[NSString month:tempDate],[budgetFromDay integerValue]];
        
        if([[NSString month:tempDate]integerValue]==1)
        {
            beginStr = [NSString stringWithFormat:@"%ld12%02ld000000",[[NSString year:tempDate] integerValue]-1,[budgetFromDay integerValue]+1];
        }
        else
        {
            endStr =[NSString stringWithFormat:@"%@%02ld%02ld000000",[NSString year:tempDate],[[NSString month:tempDate] integerValue]-1,[budgetFromDay integerValue]+1];
        }
        
        myArr= [[XDatabase shareInstance]getDataarrayFrome:beginStr toEnd:endStr];
    }
    NSInteger totalNum=0;
    totalNum = [[myArr valueForKeyPath:@"@sum.spendcount"]integerValue];
    NSArray *weekArray = [[XDatabase shareInstance]getDataFromType:[NSString stringWithFormat:@"%d",CYCLE_EVERYWEEK ]withSItype:isType];
    NSInteger weekEvry = [[weekArray valueForKeyPath:@"@sum.spendcount"]integerValue];
    NSInteger totalWeek = weekEvry * [NSString getCountWeekBetweenDate:tempDate withBugetDay:budgetFromDay];
    
    NSArray *dayArray = [[XDatabase shareInstance]getDataFromType:[NSString stringWithFormat:@"%d",CYCLE_EVERYDAY]withSItype:isType];
    NSInteger dayEvery = [[dayArray valueForKeyPath:@"@sum.spendcount"]integerValue];
    NSInteger totalDay = dayEvery * [NSString getCountDayBetweenDate:tempDate withBugetDay:budgetFromDay];
    
    NSArray *mouthArray = [[XDatabase shareInstance]getDataFromType:[NSString stringWithFormat:@"%d",CYCLE_EVERYMOUTH] withSItype:isType];
    NSInteger totalM = [[mouthArray valueForKeyPath:@"@sum.spendcount"]integerValue];
    return totalNum + totalDay + totalWeek + totalM;

}



@end
