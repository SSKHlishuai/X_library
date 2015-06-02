//
//  IncomeTable.h
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ManageTypeProtocol.h"

@interface IncomeTable : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *_dataArray;
}

@property(nonatomic,assign)id<ManageTypeProtocol> MTAdelegate;

-(void)getLocalData;

@end
