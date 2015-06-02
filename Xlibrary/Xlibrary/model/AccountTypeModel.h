//
//  AccountTypeModel.h
//  Xlibrary
//
//  Created by mc on 15/4/25.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountTypeModel : NSObject


-(instancetype)initWihtDict:(NSDictionary*)dict  withKey:(NSString*)key;

@property (nonatomic,strong)NSString *accountKey;
@property (nonatomic,strong)NSString *gestureStr;
@property (nonatomic,strong)NSString *isGestureOn;
@property (nonatomic,strong)NSString *budgetStr;
@property (nonatomic,strong)NSString *isOnBudget;
@property (nonatomic,strong)NSString *isCanDelete;


@end
