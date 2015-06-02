//
//  PwdTopVIew.m
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "PwdTopVIew.h"

@implementation PwdTopVIew
{
    TYPE_VerifyOrReset currentType;
    NSMutableArray      *rectArr;
    NSString        *pwdStr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withType:(TYPE_VerifyOrReset)_typeVR
{
    self = [super initWithFrame:frame];
    if(self)
    {
        currentType = _typeVR;
        [self initilizeRect];
        rectArr = [[NSMutableArray alloc]init];
        pwdStr = @"";
    }
    return self;
}

-(void)initilizeRect
{
    UIImageView *bgimage = [[UIImageView alloc]init];
    bgimage.frame = FRAME(0, 0, self.width, self.height);
    if(currentType == TYPE_VerifyOrReset_verify||currentType == TYPE_VerifyOrReset_delete)
    {
        bgimage.image=IMAGE_NAMED(@"passcode green background");
    }
    else
    {
        bgimage.image = IMAGE_NAMED(@"passcode red background");
    }
    [self addSubview:bgimage];
    
    
    UIImageView *lockImage = [[UIImageView alloc]initWithFrame:FRAME((kScreenWidth-60)/2, 25, 60, 60)];
    lockImage.image = IMAGE_NAMED(@"passcode");
    lockImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:lockImage];
    
    
    
    for(int i=0;i<4;i++)
    {
        UIImageView *rectImage = [[UIImageView alloc]init];
        rectImage.frame = FRAME(30+((kScreenWidth-260)/3+50)*i, lockImage.bottomY + 25, 50, 50);
        rectImage.backgroundColor = HexRGB(0xffffff);
        rectImage.layer.borderColor = [HexRGB(0xe3e3e3)CGColor];
        rectImage.layer.borderWidth = 0.5f;
        rectImage.contentMode = UIViewContentModeCenter;
        rectImage.image = IMAGE_NAMED(@"");
        rectImage.layer.shadowColor =[HexRGB(0x333333)CGColor];
        rectImage.layer.shadowOpacity = 0.5;
        rectImage.layer.shadowRadius = 1.f;
        rectImage.layer.shadowOffset = CGSizeMake(0, 2);
        rectImage.tag = i+200;
        [self addSubview:rectImage];
        [rectArr addObject:[NSString stringWithFormat:@"%ld",rectImage.tag]];
    }
    
    
}

-(void)addPwd:(NSString*)pwdchar
{
    if(pwdStr.length>=4)
    {
        return;
    }
    if([pwdchar isEqualToString:@"-1"])
    {
        if(pwdStr.length==0)
        {
            return;
        }
        else
        {
            

            pwdStr = [pwdStr substringWithRange:NSMakeRange(0, pwdStr.length-1)];
            UIImageView *rectimage = (UIImageView*)[self viewWithTag:pwdStr.length+200];
            rectimage.image = IMAGE_NAMED(@"");
            rectimage.layer.borderColor = [HexRGB(0xe3e3e3)CGColor];
           
        }
    }
    else
    {
        NSInteger temp = pwdStr.length+200;
        UIImageView *rectimage = (UIImageView*)[self viewWithTag:temp];
        rectimage.image = IMAGE_NAMED(@"password");
        rectimage.layer.borderColor = [HexRGB(0x8f8f8f)CGColor];
        
        pwdStr = [NSString stringWithFormat:@"%@%@",pwdStr,pwdchar];
        
        if(pwdStr.length >= 4)
        {
            //pwdStr = @"";
            //[self resetRectArr];
            [self performSelector:@selector(resetRectArr) withObject:nil afterDelay:0.5];
        }
        else
        {
            
        }

        
    }
}

-(void)resetRectArr
{
    if([self.myDelegate respondsToSelector:@selector(returnStr:)])
    {
        [self.myDelegate performSelector:@selector(returnStr:) withObject:pwdStr];
    }
    
    
    pwdStr = @"";
    for(int i=0;i<4;i++)
    {
        UIImageView *rectimage = (UIImageView*)[self viewWithTag:i+200];
        rectimage.image = IMAGE_NAMED(@"");
        rectimage.layer.borderColor = [HexRGB(0xe3e3e3)CGColor];
    }
}

@end
