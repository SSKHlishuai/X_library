//
//  PwdCollectionViewCell.m
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "PwdCollectionViewCell.h"

@implementation PwdCollectionViewCell
{
    UIButton *_mylabel;
}

-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr=titleStr;
    if(!_mylabel)
    {
        _mylabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _mylabel.frame = FRAME(0, 0, self.frame.size.width, self.frame.size.height);
//        _mylabel.textAlignment= NSTextAlignmentCenter;
//        _mylabel.font = Label_font(22.f);
//        _mylabel.textColor = HexRGB(0x8f8f8f);
        _mylabel.titleLabel.font = Label_font(28.f);
        _mylabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_mylabel setTitleColor:HexRGB(0x8f8f8f) forState:UIControlStateNormal];
        _mylabel.backgroundColor = HexRGB(SSSColor);
        [self.contentView addSubview:_mylabel];
        self.contentView.backgroundColor = HexRGB(SSSColor);
        _mylabel.enabled=NO;
    }
    [_mylabel setTitle:titleStr forState:UIControlStateNormal];
    

}

-(void)changeColor
{
    _mylabel.backgroundColor = HexRGB(0xe3e3e3);
  //  [_mylabel setTitle:@"afsga" forState:UIControlStateNormal];
    
    [self performSelector:@selector(resetColor) withObject:nil afterDelay:0.2];
}

-(void)resetColor
{
    _mylabel.backgroundColor = HexRGB(SSSColor);

}


@end
