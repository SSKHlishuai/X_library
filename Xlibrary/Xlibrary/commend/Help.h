//
//  Help.h
//  Xlibrary
//
//  Created by mc on 15/5/11.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Help : NSObject

/**
 *
 *
 *  @param type 无 日月天
 *
 *  @return <#return value description#>
 */
+(NSInteger)getType:(NSString*)type;
/**
 *  <#Description#>
 *
 *  @param model
 *
 *  @return 返回图片名称
 */
+(NSString*)getImageName:(XPIModel*)model;


/**
 *  <#Description#>
 *
 *  @param model <#model description#>
 *
 *  @return 返回类型名称
 */
+(NSString*)getTypeChineseName:(XPIModel*)model;


/**
 *  <#Description#>
 *
 *  @param tempDate 查看的时间nsdate
 *
 *  @return 根据budgetfrom得出一个预定周期的所有花销
 
 */
+(NSInteger)getTotalMoney:(NSDate *)tempDate withISType:(NSString *)isType;

+(NSString *)getTotalWeek:(NSDate *)date;

@end
