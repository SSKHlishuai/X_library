//
//  AccountTypeModel.m
//  Xlibrary
//
//  Created by mc on 15/4/25.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AccountTypeModel.h"

@implementation AccountTypeModel


-(instancetype)initWihtDict:(NSDictionary*)dict withKey:(NSString*)key
{
    self = [super init];
    
    if(self)
    {
        self.accountKey = [NSString stringWithFormat:@"%@",key];
        
        //NSDictionary *childDict = [dict objectForKey:key];
        self.gestureStr = NSStringFormat([dict objectForKey:@"gesture"]);
        self.isGestureOn = NSStringFormat([dict objectForKey:@"isGestureOn"]);
        self.budgetStr = NSStringFormat([dict objectForKey:@"budget"]);
        self.isOnBudget = NSStringFormat([dict objectForKey:@"isBudgetOn"]);
        
    
    }
    
    
    
    return self;
}

@end
