//
//  ManageTypeProtocol.h
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ManageTypeModel;

@protocol ManageTypeProtocol <NSObject>

-(void)pushManageAddType:(ManageTypeModel*)model;

@end
