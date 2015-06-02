//
//  StatisticalRemainViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalRemainViewController.h"
#import "StatisticalRotatingView.h"
#import "StatisticalProgressView.h"
#import "SelectTimeView.h"

#define Bottom_height   130.f
#define Top_height      240.f
#define TIMELABEL_FONT      16.f
#define SelectTimeHeight    240.f


@interface StatisticalRemainViewController ()
{
    StatisticalRotatingView *topView;
    StatisticalProgressView *bottomView;
    UILabel         *_beginlabel;
    UILabel         *_endlabel;
    SelectTimeView  *_selectTimeView;

}
@end

@implementation StatisticalRemainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setControls];
    self.view.backgroundColor = HexRGB(0xfcfcea);
    [self InitilizeTop];

    // Do any additional setup after loading the view.
}
#pragma mark - SET Controls
-(void)setControls
{
     topView= [[StatisticalRotatingView alloc]initWithFrame:FRAME((kScreenWidth-161)/2, 100, 161, Top_height)];
    [self.view addSubview:topView];
    [topView showAnimation];
    
    bottomView = [[StatisticalProgressView alloc]initWithFrame:FRAME(10, kScreenHeight-Bottom_height-NavaStatusHeight-40, kScreenWidth-20.f, Bottom_height)];
    bottomView.backgroundColor = HexRGB(0xfcfcea);
    [bottomView setNeedsDisplay];
    [bottomView test];
    [self.view addSubview:bottomView];
    
}

-(void)InitilizeTop
{
    UIButton    *timeScopeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeScopeBtn.frame=FRAME(0, 0, kScreenWidth, 40);
    [timeScopeBtn addTarget:self action:@selector(timescopeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeScopeBtn];
    
    _beginlabel = [[UILabel alloc]initWithFrame:FRAME(0, 0, (kScreenWidth-20)/2, 40.f)];
    _beginlabel.textAlignment = NSTextAlignmentRight;
    _beginlabel.font = [UIFont boldSystemFontOfSize:TIMELABEL_FONT];
    _beginlabel.textColor = [UIColor blackColor];
    [timeScopeBtn addSubview:_beginlabel];
    
    UILabel     *middleLabel = [[UILabel alloc]initWithFrame:FRAME(_beginlabel.rightX, 0, 20, 40)];
    middleLabel.textAlignment = NSTextAlignmentCenter;
    middleLabel.font = [UIFont boldSystemFontOfSize:TIMELABEL_FONT];
    middleLabel.textColor = [UIColor blackColor];
    middleLabel.text = @"~";
    [timeScopeBtn addSubview:middleLabel];
    
    _endlabel = [[UILabel alloc]initWithFrame:FRAME(middleLabel.rightX, 0, (kScreenWidth-20)/2, 40)];
    _endlabel.textAlignment = NSTextAlignmentLeft;
    _endlabel.textColor = [UIColor blackColor];
    _endlabel.font = [UIFont boldSystemFontOfSize:TIMELABEL_FONT];
    [timeScopeBtn addSubview:_endlabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:FRAME(10, timeScopeBtn.bottomY+5, kScreenWidth-20, 0.5)];
    lineView.backgroundColor = HexRGB(LINE_COLOR);
    [self.view addSubview:lineView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:FRAME((kScreenWidth-100)/2, lineView.bottomY + 10, 100.f, 20)];
    label1.font = Label_font(18.f);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HexRGB(0x333333);
    label1.text = @"现金";
    [self.view addSubview:label1];
    
    
    NSDate *nowDate = [NSDate date];
    NSString *beginStr = @"";
    beginStr = [NSString stringWithFormat:@"%d/%02d/%02d",[[NSString year:nowDate]intValue],[[NSString month:nowDate] intValue],1];
    _beginlabel.text = beginStr;
    NSString *endStr = @"";
    endStr = [NSString stringWithFormat:@"%d/%02d/%02d",[[NSString year:nowDate] intValue],[[NSString month:nowDate]intValue],[[beginStr nowMonthDays:nowDate] intValue]];
    _endlabel.text = endStr;
    
    
}
#pragma mark - Actions
#pragma mark - actions
-(void)timescopeClick
{
    if(!_selectTimeView)
    {
        _selectTimeView = [[SelectTimeView alloc]initWithFrame:FRAME(20, 200, kScreenWidth-40, SelectTimeHeight)];
        [_selectTimeView setTwoTF:_beginlabel.text withEndTXT:_endlabel.text];
        __weak StatisticalRemainViewController *_home = self;
        _selectTimeView.myBlock =^(NSString*beginSt,NSString *endSt) {
            [_home changeBegin:beginSt withEnd:endSt];
        };
        
    }
    else
    {
        [_selectTimeView show];
        [_selectTimeView setTwoTF:_beginlabel.text withEndTXT:_endlabel.text];
    }
    
    
}

-(void)changeBegin:(NSString*)benginS withEnd:(NSString*)endS
{
    _beginlabel.text = benginS;
    _endlabel.text = endS;
    
    [topView showAnimation];
    [bottomView reset];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
