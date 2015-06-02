//
//  DetailSelectview.m
//  Xlibrary
//
//  Created by wgl7569 on 15-5-4.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "DetailSelectview.h"
#define CONTBUTTONWH kScreenWidth/5
@implementation DetailSelectview
{
    NSArray *detaileArray;
    UIPageControl *pageControl;
    NSInteger detaileArrayCount;
    NSInteger lastSelect;
    UIScrollView *backScrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        lastSelect = 100;
        if (1){
            detaileArray = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]objectForKey:@"spend"];
        }
        else{
            detaileArray = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]objectForKey:@"income"];
        }
        detaileArrayCount = [detaileArray count];
        [self initWithSubViewWithFrame:frame];
    }
    return self;
}
-(UIButton *)createButtonWithImage:(NSString *)image title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(40, 100, 50, 70);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15, 18, 0, 0)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -34, 0, 0)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
    
}

-(void)initWithSubViewWithFrame:(CGRect)rect{
    if ([detaileArray count] <= 5){
        self.frame = CGRectMake(rect.origin.x,rect.origin.y, kScreenWidth, kScreenWidth/5);
    }
    else{
        self.frame = CGRectMake(rect.origin.x,rect.origin.y, kScreenWidth, kScreenWidth/5*2+30);
    }
    
    self.backgroundColor = COLOR_DIFFERENT_VAULE(234, 231, 200);
     backScrollView= [[UIScrollView alloc]init];
    [backScrollView setShowsHorizontalScrollIndicator:NO];
    [backScrollView setShowsVerticalScrollIndicator:NO];
    backScrollView.pagingEnabled  = YES;
    backScrollView.delegate = self;
    [backScrollView setBackgroundColor:[UIColor clearColor]];
    backScrollView.frame = CGRectMake(0, 0, self.width, self.height+20);
    backScrollView.contentSize = CGSizeMake(((detaileArrayCount-1)/10+1)*kScreenWidth, self.height);
    [self addSubview: backScrollView];

    pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake((kScreenWidth-100)/2,self.height-20 , 100, 20);
    pageControl.numberOfPages = ([detaileArray count]-1)/10 + 1;
    [self addSubview:pageControl];

    for (int i = 0;i < detaileArrayCount ; i ++){
        UIButton *contBtn = [self createButtonWithImage:[[detaileArray objectAtIndex:i]objectForKey:@"typeImage"] title:[[detaileArray objectAtIndex:i]objectForKey:@"typeName"]];
        if (i/5%2 == 0) {
            contBtn.frame = CGRectMake((i/5/2*5+i%10)*CONTBUTTONWH, 0, CONTBUTTONWH, CONTBUTTONWH);
        }
        else{
            contBtn.frame = CGRectMake((i/5/2*5+(i-5)%10)*CONTBUTTONWH, CONTBUTTONWH , CONTBUTTONWH, CONTBUTTONWH);
        }
         contBtn.tag = 100+i;
        [contBtn addTarget:self action:@selector(contBtnAction:) forControlEvents:UIControlEventTouchDown];
        [backScrollView addSubview:contBtn];
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    XLog(@"%@",NSStringFromCGSize(scrollView.contentSize));
    CGFloat scrollViewW = scrollView.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x+scrollViewW/2)/scrollViewW;
    [pageControl setCurrentPage:page];
}
-(void)contBtnAction:(UIButton*)sender
{
    UIButton *btn = (UIButton *)[backScrollView viewWithTag:lastSelect];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setSelected:NO];
    [sender setSelected:YES];
    [sender setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.1]];
    lastSelect = sender.tag;
    _typeTag = [[detaileArray objectAtIndex:sender.tag-100]objectForKey:@"typeTag"];
}
@end
