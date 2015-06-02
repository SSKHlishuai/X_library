//
//  PwdFloorView.h
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PwdTopVIew.h"


@interface PwdFloorView : UIView


@property (nonatomic,strong)id<PwdFloorViewDelegate>myDelegate;

-(instancetype)initWithFrame:(CGRect)frame withVerifyOrReset:(TYPE_VerifyOrReset)verifyOrReset;

@end
