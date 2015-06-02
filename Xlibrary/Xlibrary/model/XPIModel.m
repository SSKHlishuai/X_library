//
//  XPIModel.m
//  Xlibrary
//  pay and income model
//  Created by mc on 15/4/23.
//  Copyright (c) 2015年 mc. All rights reserved.
//  支出 收入 的 model

#import "XPIModel.h"

@implementation XPIModel
-(void)setCreateInfo:(NSDate *)date{
    self.createtime = [NSString returnCreateTime:date];
    self.cyear = [NSString year:date];
    self.cmonth = [NSString month:date];
    self.cday  = [NSString day:date];
}

@end
