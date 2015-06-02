//
//  AccountTypeCell.m
//  Xlibrary
//
//  Created by mc on 15/4/25.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AccountTypeCell.h"

@implementation AccountTypeCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)init
{
    self = [super init];
    if(self)
    {
        [self Initilize];
    }
    return self;
}


-(void)Initilize
{
    self.contentView.backgroundColor = HexRGB(SSSColor);
    UIButton *floorView = [UIButton buttonWithType:UIButtonTypeCustom];
    floorView.frame= FRAME(20, 10, kScreenWidth-40, 45);
    floorView.backgroundColor = HexRGB(SSSColor);
    floorView.layer.borderColor = [HexRGB(LINE_COLOR)CGColor];
    floorView.layer.borderWidth=.5f;
    [floorView addTarget:self action:@selector(ChangeBG:) forControlEvents:UIControlEventTouchDown];
    [floorView addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:floorView];
    
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:FRAME(8, 5, 37, 37)];
    leftImage.image = IMAGE_NAMED(@"icon_setting_account");
    leftImage.contentMode = UIViewContentModeScaleAspectFit;
    [floorView addSubview:leftImage];
    self.titleLable = [[UILabel alloc]initWithFrame:FRAME(leftImage.rightX, 0, floorView.width-leftImage.rightX-20, 45)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.font = Label_font(22.f);
    _titleLable.textColor= HexRGB(0x444444);
    [floorView addSubview:_titleLable];
    floorView.enabled=NO;
    
}

-(void)ChangeBG:(UIButton*)button
{
    button.backgroundColor = HexRGB(0xf5f5dc);
}

-(void)pushDetail:(UIButton*)button
{
    button.backgroundColor = HexRGB(SSSColor);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
