//
//  StatisticalProgressView.m
//  Xlibrary
//
//  Created by mc on 15/4/24.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalProgressView.h"
#import "THProgressView.h"



#define CR_RADIUS 1.5
#define SmallRectWidth 12
#define income_color    HexRGB(0xb3ee3a)
#define budget_color    HexRGB(0xff7f24)
#define spend_color     HexRGB(0xff4040)

@interface StatisticalProgressView ()
{
    THProgressView  *_incomePro;
    THProgressView  *_budgetPro;
    THProgressView  *_spendPro;
    UILabel         *_incomeLab;
    UILabel *_budgetLab;
    UILabel *_spendLab;
}
@end
@implementation StatisticalProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self InitlizeProAndLab];
    }
    return self;
}

-(void)InitlizeProAndLab
{
    _incomePro = [[THProgressView alloc]initWithFrame:FRAME(2, 30, 200, 22)];
    _incomePro.progressTintColor = income_color;
    [self addSubview:_incomePro];
    
    _incomeLab = [[UILabel alloc]initWithFrame:FRAME(_incomePro.rightX + 10, 30, self.width-_incomePro.rightX-10, 22)];
    _incomeLab.textAlignment = NSTextAlignmentRight;
    _incomeLab.textColor = HexRGB(0x444444);
    _incomeLab.font = Label_font(14.f);
    [self addSubview:_incomeLab];
    
    _budgetPro = [[THProgressView alloc]initWithFrame:FRAME(2, 65, 200, 22)];
    _budgetPro.progressTintColor = budget_color;
    [self addSubview:_budgetPro];
    
    _budgetLab = [[UILabel alloc]initWithFrame:FRAME(_budgetPro.rightX + 10, 65, self.width-_budgetPro.rightX-10, 22)];
    _budgetLab.textAlignment = NSTextAlignmentRight;
    _budgetLab.textColor = HexRGB(0x444444);
    _budgetLab.font = Label_font(14.f);
    [self addSubview:_budgetLab];
    
    
    _spendPro = [[THProgressView alloc]initWithFrame:FRAME(2, 100, 200, 22)];
    _spendPro.progressTintColor=spend_color;
    [self addSubview:_spendPro];
    
    _spendLab = [[UILabel alloc]initWithFrame:FRAME(_spendPro.rightX + 10, 100, self.width-_spendPro.rightX-10, 22)];
    _spendLab.textAlignment = NSTextAlignmentRight;
    _spendLab.textColor = HexRGB(0x444444);
    _spendLab.font = Label_font(14.f);
    [self addSubview:_spendLab];
    
    
    
    
}

-(void)reset
{
    [_incomePro setProgress:0 animated:NO];
    _incomeLab.text = @"213213";
    [_budgetPro setProgress:0.f animated:NO];
    _budgetLab.text = @"1241";
    [_spendPro setProgress:0.f animated:NO];
    _spendLab.text = @"90";
    [self test];
}

-(void)test
{

    [_incomePro setProgress:0 animated:YES];
    _incomeLab.text = @"213213";
    [_budgetPro setProgress:0.5 animated:YES];
    _budgetLab.text = @"1241";
    [_spendPro setProgress:1.f animated:YES];
    _spendLab.text = @"90";
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 1);
    CGContextAddLineToPoint(context, kScreenWidth-20, 1);
    CGContextSetStrokeColorWithColor(context, HexRGB(LINE_COLOR).CGColor);
    CGContextStrokePath(context);
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentLeft;
    [@"收入" drawInRect:CGRectMake(0, 3, 24, 15) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12.f],NSFontAttributeName ,HexRGB(0x444444),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    CGContextSetStrokeColorWithColor(context, income_color.CGColor);
    CGContextSetFillColorWithColor(context, income_color.CGColor);
    //找到各个角点
    CGPoint p_0_0 = CGPointMake(25+3, 4);
    CGPoint p_0_1 = CGPointMake(25+SmallRectWidth+3, 4);
    CGPoint p_1_0 = CGPointMake(25+3, 4+SmallRectWidth);
    CGPoint p_1_1 = CGPointMake(25+SmallRectWidth+3, 4+SmallRectWidth);

    CGContextMoveToPoint(context, p_1_0.x , p_1_0.y - CR_RADIUS * 2);
    CGContextAddArcToPoint(context, p_0_0.x, p_0_0.y, p_0_0.x + CR_RADIUS*2, p_0_0.y, CR_RADIUS);
    CGContextAddArcToPoint(context, p_0_1.x, p_0_1.y, p_0_1.x, p_0_1.y  + CR_RADIUS*2, CR_RADIUS);
    CGContextAddArcToPoint(context, p_1_1.x, p_1_1.y, p_1_1.x - CR_RADIUS*2, p_1_1.y, CR_RADIUS);
    CGContextAddArcToPoint(context, p_1_0.x, p_1_0.y, p_1_0.x, p_1_0.y - CR_RADIUS*2, CR_RADIUS);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    paragraph.alignment = NSTextAlignmentLeft;
    [@"预算" drawInRect:CGRectMake((kScreenWidth-20)/2-20, 3, 24, 15) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12.f],NSFontAttributeName ,HexRGB(0x444444),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    CGContextSetStrokeColorWithColor(context, budget_color.CGColor);

    CGContextSetFillColorWithColor(context, budget_color.CGColor);

    
    //找到各个角点
    p_0_0 = CGPointMake((kScreenWidth-20)/2-20+25+3, 4);
    p_0_1 = CGPointMake((kScreenWidth-20)/2-20+25+SmallRectWidth+3, 4);
    p_1_0 = CGPointMake((kScreenWidth-20)/2-20+25+3, 4+SmallRectWidth);
    p_1_1 = CGPointMake((kScreenWidth-20)/2-20+25+SmallRectWidth+3, 4+SmallRectWidth);
    
    CGContextMoveToPoint(context, p_1_0.x , p_1_0.y - CR_RADIUS * 2);
    CGContextAddArcToPoint(context, p_0_0.x, p_0_0.y, p_0_0.x + CR_RADIUS*2, p_0_0.y, CR_RADIUS);
    CGContextAddArcToPoint(context, p_0_1.x, p_0_1.y, p_0_1.x, p_0_1.y  + CR_RADIUS*2, CR_RADIUS);
    CGContextAddArcToPoint(context, p_1_1.x, p_1_1.y, p_1_1.x - CR_RADIUS*2, p_1_1.y, CR_RADIUS);
    CGContextAddArcToPoint(context, p_1_0.x, p_1_0.y, p_1_0.x, p_1_0.y - CR_RADIUS*2, CR_RADIUS);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    
    paragraph.alignment = NSTextAlignmentLeft;
    [@"支出" drawInRect:CGRectMake(kScreenWidth-64, 3, 24, 15) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12.f],NSFontAttributeName ,HexRGB(0x444444),NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil]];
    CGContextSetStrokeColorWithColor(context, spend_color.CGColor);

    CGContextSetFillColorWithColor(context, spend_color.CGColor);

    //找到各个角点
    p_0_0 = CGPointMake(kScreenWidth-64+25+3, 4);
    p_0_1 = CGPointMake(kScreenWidth-64+25+SmallRectWidth+3, 4);
    p_1_0 = CGPointMake(kScreenWidth-64+25+3, 4+SmallRectWidth);
    p_1_1 = CGPointMake(kScreenWidth-64+25+SmallRectWidth+3, 4+SmallRectWidth);
    
    CGContextMoveToPoint(context, p_1_0.x , p_1_0.y - CR_RADIUS * 2);
    CGContextAddArcToPoint(context, p_0_0.x, p_0_0.y, p_0_0.x + CR_RADIUS*2, p_0_0.y, CR_RADIUS);
    CGContextAddArcToPoint(context, p_0_1.x, p_0_1.y, p_0_1.x, p_0_1.y  + CR_RADIUS*2, CR_RADIUS);
    CGContextAddArcToPoint(context, p_1_1.x, p_1_1.y, p_1_1.x - CR_RADIUS*2, p_1_1.y, CR_RADIUS);
    CGContextAddArcToPoint(context, p_1_0.x, p_1_0.y, p_1_0.x, p_1_0.y - CR_RADIUS*2, CR_RADIUS);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 20);
    CGContextAddLineToPoint(context, kScreenWidth-20, 20);
    CGContextSetStrokeColorWithColor(context, HexRGB(LINE_COLOR).CGColor);
    CGContextStrokePath(context);
    
    
    CGContextSetFillColorWithColor(context, income_color.CGColor);
    CGContextFillRect(context,CGRectMake(0, 30, 2, 22));//填充框
    
    CGContextSetFillColorWithColor(context, budget_color.CGColor);
    CGContextFillRect(context,CGRectMake(0, 30+35, 2, 22));//填充框
    
    
    CGContextSetFillColorWithColor(context, spend_color.CGColor);
    CGContextFillRect(context,CGRectMake(0, 30+70, 2, 22));//填充框

    
    
}



@end
