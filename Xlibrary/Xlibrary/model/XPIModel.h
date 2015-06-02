//
//  XPIModel.h
//  Xlibrary
//
//  Created by mc on 15/4/23.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPIModel : NSObject


@property (nonatomic,strong)NSString *createtime;//创建时间
@property (nonatomic,strong)NSString *cyear;     //创建年
@property (nonatomic,strong)NSString *cmonth;     //创建月
@property (nonatomic,strong)NSString *cday;     //创建天
@property (nonatomic,strong)NSString *typestr;  //类型
@property (nonatomic,strong)NSString *accoutTypestr; //账户类型
@property (nonatomic,strong)NSString *spendcount;//金额
@property (nonatomic,strong)NSString *describe;  //描述
@property (nonatomic,strong)NSString *type;      //无 日月天
@property (nonatomic,strong)NSString *spendorincome;//输入 or 支出
@property (nonatomic,strong)NSString *boolAccountDelete;//是否部分删除
@property (nonatomic,strong)NSString *deleteTime;//删除日期
-(void)setCreateInfo:(NSDate *)date;
@end
