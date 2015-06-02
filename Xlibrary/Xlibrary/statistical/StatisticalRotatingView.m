//
//  StatisticalRotatingView.m
//  Xlibrary
//
//  Created by mc on 15/4/22.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalRotatingView.h"

@interface StatisticalRotatingView ()
{
    UIImageView *_rotaImage;
    UILabel     *_countLabel;
}

@end

@implementation StatisticalRotatingView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self InitilizeContros];
    }
    return self;
}


-(void)InitilizeContros
{
    _rotaImage = [[UIImageView alloc]initWithFrame:FRAME(0, 0, self.width, self.width)];
    _rotaImage.image = IMAGE_NAMED(@"caculation pig");
    [self addSubview:_rotaImage];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:FRAME(0, _rotaImage.bottomY+10, self.width, 15)];
    label1.text = @"剩余预算";
    label1.textColor = HexRGB(0x555555);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = Label_font(14.f);
    [self addSubview:label1];
    
    _countLabel = [[UILabel alloc]initWithFrame:FRAME(0, label1.bottomY+5, self.width, 40)];
    _countLabel.textColor = HexRGB(0x361614);
    _countLabel.font = Label_font(30.f);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.text = @"0";
    [self addSubview:_countLabel];
    
}





- (CAAnimation *)animationRotate

{
    
    //    UIButton *theButton = sender;
    
    // rotate animation
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI*0.5, 0, 1,0);
    
    
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue        = [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration        = 0.9;
    
    animation.autoreverses    = YES;
    
    animation.cumulative    = YES;
    
    animation.repeatCount    = 1;
    
    animation.beginTime        = 0.3;
    
    animation.delegate        = self;
    
    
    
    return animation;
    
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag

{
    
    //todo
    
}

-(void)changeImage
{
    _rotaImage.image = IMAGE_NAMED(@"pig +");
    _countLabel.textColor =  HexRGB(0x2ea6a5);

}

- (void)showAnimation

{
    _rotaImage.image = IMAGE_NAMED(@"caculation pig");
    _countLabel.textColor =  HexRGB(0x333333);
   // UIButton *theButton = sender;
    NSTimer *yim = [NSTimer scheduledTimerWithTimeInterval:1.35 target:self selector:@selector(changeImage) userInfo:nil repeats:NO];
    
    
    
    CAAnimation* myAnimationRotate = [self animationRotate];
    
    
    CAAnimationGroup *m_pGroupAnimation     = [CAAnimationGroup animation];
    
    m_pGroupAnimation.delegate              =self;
    
    m_pGroupAnimation.removedOnCompletion   =NO;
    
    m_pGroupAnimation.duration              =3;
    
    m_pGroupAnimation.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    m_pGroupAnimation.repeatCount           =1;//FLT_MAX;  //"forever";
    
    m_pGroupAnimation.fillMode              =kCAFillModeForwards;
    
    m_pGroupAnimation.animations             = [NSArray arrayWithObjects:myAnimationRotate,nil];
    
    
    
    [self.layer addAnimation:m_pGroupAnimation forKey:@"animationRotate"];
    
}




@end
