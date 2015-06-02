//
//  ManageTypeAddCell.m
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "ManageTypeAddCell.h"

@implementation ManageTypeAddCell
{
    UIImageView *_myImageView;
}

-(void)setImageNameStr:(NSString *)imageNameStr
{
    _imageNameStr=imageNameStr;
    if(!_myImageView)
    {
        _myImageView = [[UIImageView alloc]initWithFrame:FRAME(0, 0, self.frame.size.width, self.frame.size.height)];
        _myImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_myImageView];
    }
    _myImageView.image = IMAGE_NAMED(imageNameStr);
}


-(void)setImageBGchangeColor
{
    _myImageView.backgroundColor = HexRGB(0xcdc673);
}
-(void)resetColor
{
    _myImageView.backgroundColor = HexRGB(SSSColor);
}


@end
