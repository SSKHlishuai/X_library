//
//  ManageTypeModel.h
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageTypeModel : NSObject


@property (nonatomic,strong)NSString *typeColor;            //颜色
@property (nonatomic,strong)NSString *typeTag;              //类型的id
@property (nonatomic,strong)NSString *typeType;             //是支出还是收入   支出 spend  收入  income
@property (nonatomic,strong)NSString *typeName;             //名称
@property (nonatomic,strong)NSString *typeImage;            //图片名



-(instancetype)initWithDict:(NSDictionary*)dic  withType:(NSString *)typeStr;

@end
