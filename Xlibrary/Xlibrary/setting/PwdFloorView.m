//
//  PwdFloorView.m
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "PwdFloorView.h"
#import "PwdCollectionV.h"


@interface PwdFloorView ()<PwdCollectionViewDelegate,PwdTopViewDelegate>
{
    PwdTopVIew *topView;
    UILabel     *hudLabel;
    TYPE_VerifyOrReset   currentType;
    NSInteger   oncePwd;
    NSString    *oneStr;
}

@end

@implementation PwdFloorView


-(instancetype)initWithFrame:(CGRect)frame withVerifyOrReset:(TYPE_VerifyOrReset)verifyOrReset
{
    self = [super initWithFrame:frame];
    if(self)
    {
        oncePwd = 0;
        currentType = verifyOrReset;
        [self InitilizeControls];
    }
    return self;
}


-(void)InitilizeControls
{
    
    topView = [[PwdTopVIew alloc]initWithFrame:FRAME(0, 0, kScreenWidth, kScreenHeight/2-65-NavaStatusHeight)withType:currentType];
    topView.backgroundColor = HexRGB(0xee4000);
    topView.myDelegate = self;
    [self addSubview:topView];
    
    
    hudLabel = [[UILabel alloc]initWithFrame:FRAME(0, topView.bottomY, kScreenWidth, 65)];
    hudLabel.backgroundColor = HexRGB(SSSColor);
    hudLabel.textAlignment = NSTextAlignmentCenter;
    hudLabel.textColor = HexRGB(0x333333);
    hudLabel.font = Label_font(19.f);
    hudLabel.text = @"请输入密码";
    [self addSubview:hudLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kScreenWidth/3.f, (kScreenHeight/2)/4.f);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    PwdCollectionV *pwdCollecV = [[PwdCollectionV alloc]initWithFrame:CGRectMake(0, hudLabel.bottomY, kScreenWidth, kScreenHeight/2.f) collectionViewLayout:flowLayout];
    pwdCollecV._myDelegate=self;
    pwdCollecV.backgroundColor = HexRGB(SSSColor);
    [self addSubview:pwdCollecV];

    
    
    
    
}



-(void)judgeGetpwdkeyboard:(NSString *)pwdchar
{
    [topView addPwd:pwdchar];
    NSLog(@"%@",pwdchar);
}
#pragma mark - PwdTopDelegate
-(void)returnStr:(NSString *)pwdStr
{
    if(currentType == TYPE_VerifyOrReset_delete)
    {
        NSUSERDEFAULTS(Default);
        if ([pwdStr isEqualToString:[AppUserInfor getInstanceUser].pwdStr]&&[[AppUserInfor getInstanceUser].isOnPwd isEqualToString:@"YES"]) {
            [Default setObject:@"NO" forKey:IS_ON_PWD];
            [Default setObject:@"-1" forKey:PWD_STR];
            [Default synchronize];
            
            [AppUserInfor getInstanceUser].isOnPwd = @"NO";
            [AppUserInfor getInstanceUser].pwdStr = @"-1";
            
            if([self.myDelegate respondsToSelector:@selector(deleteSuccessAndPop)])
            {
                [self.myDelegate performSelector:@selector(deleteSuccessAndPop) withObject:nil];
            }
        }
        else
        {
            hudLabel.textColor = HexRGB(0x333333);

            hudLabel.text = @"输入密码错误，请重新输入";

        }
    }
    else if(currentType == TYPE_VerifyOrReset_reset)
    {
        if(oncePwd == 0)
        {
            oncePwd =1;
            oneStr = NSStringFormat(pwdStr);
            hudLabel.textColor = HexRGB(0x333333);

            hudLabel.text = @"请再次输入密码";
        }
        else if(oncePwd == 1)
        {
            if([oneStr isEqualToString:pwdStr])
            {
                    NSUSERDEFAULTS(Default);
                    [Default setObject:@"YES" forKey:IS_ON_PWD];
                    [Default setObject:NSStringFormat(pwdStr) forKey:PWD_STR];
                    [Default synchronize];
                    
                    [AppUserInfor getInstanceUser].isOnPwd = @"YES";
                    [AppUserInfor getInstanceUser].pwdStr = NSStringFormat(pwdStr);

                if([self.myDelegate respondsToSelector:@selector(resetSuccessAndPop)])
                {
                    [self.myDelegate performSelector:@selector(resetSuccessAndPop) withObject:nil];
                }
            }
            else
            {
                hudLabel.textColor = HexRGB(0xff4040);
                hudLabel.text = @"两次输入的密码不一致";
                oneStr = @"";
                oncePwd = 0;
            }
        }
        
    }
    else if(currentType == TYPE_VerifyOrReset_verify)
    {
        if ([pwdStr isEqualToString:[AppUserInfor getInstanceUser].pwdStr]&&[[AppUserInfor getInstanceUser].isOnPwd isEqualToString:@"YES"]) {
                        if([self.myDelegate respondsToSelector:@selector(deleteSuccessAndPop)])
            {
                [self.myDelegate performSelector:@selector(verifySuccessAndPop) withObject:nil];
            }
        }
        else
        {
            hudLabel.textColor = HexRGB(0xff4040);

            hudLabel.text = @"输入密码错误，请重新输入";
            
        }


    }
}

@end
