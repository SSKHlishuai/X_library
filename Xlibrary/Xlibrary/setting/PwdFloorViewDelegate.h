//
//  PwdFloorViewDelegate.h
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PwdFloorViewDelegate <NSObject>

-(void)deleteSuccessAndPop;
-(void)resetSuccessAndPop;
-(void)verifySuccessAndPop;

@end



@protocol PwdTopViewDelegate <NSObject>

-(void)returnStr:(NSString*)pwdStr;


@end