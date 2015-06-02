//
//  AppUserInfor.m
//  Xlibrary
//
//  Created by mc on 15/4/29.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AppUserInfor.h"

@implementation AppUserInfor


static AppUserInfor *shareUser = nil;

+(AppUserInfor *) getInstanceUser{
    
    @synchronized(self)
    {
        if (shareUser == nil)
        {
            shareUser = [[self alloc] init];
        }
    }
    return shareUser;
}

+(void)initUser{
    
    shareUser = nil;
}

+(AppUserInfor*)defaultUserInfo
{
    @synchronized(self)
    {
        if (shareUser==nil) {
            
            shareUser = [[self alloc] init];
        }
    }
    return shareUser;
}

@end
