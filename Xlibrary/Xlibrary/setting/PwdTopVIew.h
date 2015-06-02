//
//  PwdTopVIew.h
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PwdFloorViewDelegate.h"

typedef enum
{
    TYPE_VerifyOrReset_verify=0,
    TYPE_VerifyOrReset_reset,
    TYPE_VerifyOrReset_delete
}TYPE_VerifyOrReset;

@interface PwdTopVIew : UIView


@property (nonatomic,assign)id<PwdTopViewDelegate>myDelegate;

-(instancetype)initWithFrame:(CGRect)frame withType:(TYPE_VerifyOrReset)_typeVR;

-(void)addPwd:(NSString*)pwdchar;
@end
