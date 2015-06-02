//
//  AppUserInfor.h
//  Xlibrary
//
//  Created by mc on 15/4/29.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUserInfor : NSObject

@property (nonatomic,strong)NSString *isOnPwd;//是否开启密码
@property (nonatomic,strong)NSString *pwdStr;//密码
@property (nonatomic,strong)NSString *budgetCount;//预算总额 默认10000
@property (nonatomic,strong)NSString *budgetOn;//是否显示预算到收入支出页面
@property (nonatomic,strong)NSString *budgetFrom;//预算从第几日算起


+(AppUserInfor *) getInstanceUser;
+(void)initUser;
@end
