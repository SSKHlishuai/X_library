//
//  ManageAddTypeVController.h
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ManageTypeModel.h"

typedef enum
{
    Type_CA_Add= 0,
    Type_CA_Change
}Type_CA;

@interface ManageAddTypeVController : BaseViewController


@property (nonatomic,strong)ManageTypeModel *selectModel;
-(instancetype)initWithNewOrChange:(Type_CA)type WithSpendOrIncome:(NSInteger)Spenorincome;


@end
