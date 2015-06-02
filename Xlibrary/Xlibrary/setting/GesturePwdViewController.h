//
//  GesturePwdViewController.h
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PwdFloorView.h"



@protocol GPwdVerifyDelegate <NSObject>

-(void)changeRootViewController;

@end

@interface GesturePwdViewController : BaseViewController

@property (nonatomic,assign)id<GPwdVerifyDelegate>gestDelegate;

-(instancetype)initWithType:(TYPE_VerifyOrReset)verifyOrReset;


@end
