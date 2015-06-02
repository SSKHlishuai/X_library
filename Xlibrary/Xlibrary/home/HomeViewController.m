//
//  HomeViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "HomeViewController.h"
#import "DataView.h"
#import "DateModel.h"
#import "FootViewForDetail.h"
#define FOOTVIEWHEIGH 60
#define NAVHEIGHT 64
#define TOOLBARHEIGHT 44

@interface HomeViewController (){
    NSDate *curDate;
    NSArray *lastDateArry;
    NSArray *curDateArray;
    NSArray *nextDateArray;
    DataView *dateView ;
    UIScrollView *blackS;
    DateModel *dateModel;
    DetailView *detailViewLast;
    DetailView *detailViewCur;
    DetailView *detailViewNext;
    FootViewForDetail *footView;
    UIDatePicker *_dataPicker;
    UIView *_datePickerBackView;
    BOOL isShowDataPicker;
    BOOL isShowFootView;
    NSString *spendOrIncome;
    NSInteger datePickerHight;
    NSInteger totalNumberMoney;
}

@end
enum{
    RIGHTBTN_CALENDAR = 10001,
    RIGHTBTN_ADD,
    DATEPICK_DO,
    DATEPICK_UNDO
    
};
@implementation HomeViewController

- (void)viewDidLoad {
    if (_stypeSpendOrIncome == SEPENDINCOME_INCOME){
        spendOrIncome = @"income";
    }
    else{
        spendOrIncome = @"spend";
    }
    [super viewDidLoad];
    curDate = [NSDate date];
    isShowDataPicker = NO;
    dateModel = [DateModel sharedDateModel];
    [self loadNavigationItemView];
    [self loadFootView];

    [self refreshViewShowInfo];
    [self loadMainView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDatePicker];
    [self loadStatusSelfView];
    datePickerHight  = _dataPicker.height;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)loadStatusSelfView{
       if (_stypeSpendOrIncome == SEPENDINCOME_INCOME){
           [self showFootViewWithBool:NO];
        [blackS setBackgroundColor:[UIColor greenColor]];
    }
    else{
        [self showFootViewWithBool:YES];
        blackS.backgroundColor = [UIColor orangeColor];

    }
}
-(void)showFootViewWithBool:(BOOL)isShow{
    if (isShow){
        blackS.height = self.view.height - FOOTVIEWHEIGH-NAVHEIGHT;
        detailViewCur.frame = CGRectMake(blackS.width, 0, blackS.width, blackS.height);
        detailViewLast.frame = CGRectMake(0, 0, blackS.width, blackS.height);
        detailViewNext.frame = CGRectMake(blackS.width*2, 0, blackS.width, blackS.height);
    }
    else{
        footView.frame = CGRectMake(0, self.view.height-NAVHEIGHT, self.view.width, FOOTVIEWHEIGH);
    }
}

-(void)loadDatePicker{
    _dataPicker  = [[UIDatePicker alloc]init];
    _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, TOOLBARHEIGHT, 0 , 0)];
    _datePickerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-NAVHEIGHT, self.view.width, _dataPicker.height+TOOLBARHEIGHT)];
    [_datePickerBackView addSubview:_dataPicker];
    [self.view addSubview:_datePickerBackView];
    //日期模式
    NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _dataPicker.locale = local;
    _dataPicker.backgroundColor = [UIColor grayColor];
    [_dataPicker setDatePickerMode:UIDatePickerModeDate];
    //定义最小日期
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    [_dataPicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    
    
    toolBar.frame = CGRectMake(0, 0, kScreenWidth, TOOLBARHEIGHT);
    UIButton *btnDo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDo.frame =CGRectMake(0, 0, 50, 20);
    [btnDo setBackgroundColor:[UIColor greenColor]];
    [btnDo setTitle:@"完成" forState:UIControlStateNormal];
    btnDo.tag = DATEPICK_DO;
    [btnDo addTarget:self action:@selector(datePickToolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *b1 = [[UIBarButtonItem alloc]initWithCustomView:btnDo];
    
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *btnCl = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCl.frame =CGRectMake(0, 0, 50, 20);
    [btnCl setBackgroundColor:[UIColor redColor]];
    [btnCl setTitle:@"取消" forState:UIControlStateNormal];
    btnCl.tag = DATEPICK_UNDO;
    [btnCl addTarget:self action:@selector(datePickToolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *b2 = [[UIBarButtonItem alloc]initWithCustomView:btnCl];
    
    toolBar.items  = @[b1,item,item,b2];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [_datePickerBackView addSubview:toolBar];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter = nil;
    
    
}
-(NSDate*)getNextDayDate:(NSDate *)date{
    NSDate *nDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
    return nDate;
}
-(NSDate*)getLastDayDate:(NSDate *)date{
    NSDate *lDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
    return lDate;
}

-(void)datePickToolbarAction:(UIButton *)sender{
    if (sender.tag == DATEPICK_DO){
        curDate = _dataPicker.date;
        [dateView setDatePickSelectDate:_dataPicker.date];
        id __weak tSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            blackS.contentOffset = CGPointMake(kScreenWidth *2, 0);
        } completion:^(BOOL finished) {
            blackS.contentOffset = CGPointMake(kScreenWidth, 0);
            [tSelf reloadViewBySelf];
        }];

        
    }
    else if (sender.tag == DATEPICK_UNDO){
        
    }
    if (!isShowDataPicker){
      [UIView animateWithDuration:.5 animations:^{
          _datePickerBackView.transform = CGAffineTransformMakeTranslation(0, datePickerHight + TOOLBARHEIGHT);
      }];
    }
}
-(void)dataValueChanged:(id)sender
{
}
- (void)refreshViewShowInfo{
    totalNumberMoney = [Help getTotalMoney:curDate withISType:spendOrIncome];
    [footView setValue:[NSString stringWithFormat:@"%ld",(long)totalNumberMoney] forKeyPath:@"footViewForDetailModel.oddNumber"];
};
-(void)loadFootView{
    footView= [[FootViewForDetail alloc]initWithFrame:CGRectMake(0, self.view.height-FOOTVIEWHEIGH-NAVHEIGHT, self.view.width, FOOTVIEWHEIGH)];
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[AppUserInfor getInstanceUser].budgetCount]);
    [footView setValue:[NSString stringWithFormat:@"%@",[AppUserInfor getInstanceUser].budgetCount]forKeyPath:@"footViewForDetailModel.totalNumber"];
    [self.view addSubview:footView];
}
-(NSArray *)getDataArrayFromDataBase:(NSDate *)date{
    NSArray *array = [[XDatabase shareInstance]getDataFormTime:date withType:spendOrIncome];
    return array;
}
-(void)loadMainView{
    blackS= [[UIScrollView alloc]init];
//       blackS.backgroundColor = COLOR_DIFFERENT_VAULE(212, 122, 122);
    blackS.frame = self.view.bounds;
    blackS.contentSize = CGSizeMake(self.view.width*3, blackS.height - FOOTVIEWHEIGH-NAVHEIGHT);
    blackS.contentOffset = CGPointMake(self.view.width, 0);
    blackS.showsVerticalScrollIndicator = NO;
    blackS.showsHorizontalScrollIndicator= NO;
    blackS.delegate = self;
    blackS.pagingEnabled = YES;
    

    curDateArray = [self getDataArrayFromDataBase:curDate];;
    lastDateArry = [self getDataArrayFromDataBase:[self getLastDayDate:curDate]];
    nextDateArray = [self getDataArrayFromDataBase:[self getNextDayDate:curDate]];
    detailViewCur = [[DetailView alloc]initWithFrame:CGRectMake(blackS.width, 0, blackS.width, blackS.height) ];
    detailViewCur.delegate = self;
    [detailViewCur loadFromDta:curDateArray];
    [blackS addSubview:detailViewCur];
    detailViewLast = [[DetailView alloc]initWithFrame:CGRectMake(0, 0, blackS.width, blackS.height) ];
    [detailViewLast loadFromDta:lastDateArry];
    [blackS addSubview:detailViewLast];
    detailViewNext = [[DetailView alloc]initWithFrame:CGRectMake(blackS.width*2, 0, blackS.width, blackS.height) ];
    [detailViewNext loadFromDta:nextDateArray];
    [blackS addSubview:detailViewNext];
    
    
    [self.view addSubview:blackS];
    
}
-(void)loadNavigationItemView{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:nil highImageName:nil target:self action:@selector(leftBarButtonItemAction) ];
    UIButton *rightBtnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtnAdd setBackgroundImage:IMAGE_NAMED(@"add icon") forState:UIControlStateNormal];
    rightBtnAdd.frame = CGRectMake(50,0, 35, 35);
    rightBtnAdd.showsTouchWhenHighlighted = YES;
    [rightBtnAdd addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtnAdd.tag = RIGHTBTN_ADD;
    [self.navigationController.navigationBar addSubview:rightBtnAdd];
    
    UIButton *rightBtnCalendar = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtnCalendar setBackgroundImage:IMAGE_NAMED(@"calendar_icon") forState:UIControlStateNormal];
    rightBtnCalendar.frame = CGRectMake(0,0, 40, 40);
    [rightBtnCalendar addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtnCalendar.tag = RIGHTBTN_CALENDAR;
    rightBtnCalendar.showsTouchWhenHighlighted = YES;
    
    
    UIView *rightV = [[UIView alloc]init];
    rightV.frame = CGRectMake(0, 0, 90, 40);
    [rightV addSubview:rightBtnCalendar];
    [rightV addSubview:rightBtnAdd];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightV];
    
    
//    [self.navigationController.navigationBar addSubview:rightBtnCalendar];
    dateView = [[DataView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    
    self.navigationItem.titleView = dateView;
    
}

-(void)showEditViewControllerWithDataModel:(XPIModel *)mode{
    EditViewController *edv = [[EditViewController alloc]init];
    edv.delegate = self;
    edv.dataModel = mode;
    [self.navigationController pushViewController:edv animated:YES];
}
#pragma mark   ------ Action ----------
/**
 *  超过预算周期一个月要刷新此处
 
 */
-(void)updateFoot
{
    
}

#pragma mark   scrollviewdelgate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    if (page == 0){
        [dateView showLastDary];
        nextDateArray = curDateArray ;
        curDateArray = lastDateArry;
        curDate = [self getLastDayDate:curDate];
        lastDateArry = [self getDataArrayFromDataBase:[self getLastDayDate:curDate]];;
        scrollView.contentOffset = CGPointMake(self.view.width, 0);
    }
    else if (page == 2){
        [dateView showNextDay];
        lastDateArry = curDateArray;
        curDateArray = nextDateArray;
        curDate = [self getNextDayDate:curDate];
        nextDateArray = [self getDataArrayFromDataBase:[self getNextDayDate:curDate]];
        scrollView.contentOffset = CGPointMake(self.view.width, 0);
    }
    else{
        
    }
    [detailViewCur loadFromDta:curDateArray];
    [detailViewLast loadFromDta:lastDateArry];
    [detailViewNext loadFromDta:nextDateArray];
    if ([[NSString day:curDate]integerValue] == [[AppUserInfor getInstanceUser].budgetFrom integerValue]
        ||[[NSString day:[self getLastDayDate:curDate]]integerValue] == [[AppUserInfor getInstanceUser].budgetFrom integerValue]
        ||[[NSString day:[self getNextDayDate:curDate]]integerValue] == [[AppUserInfor getInstanceUser].budgetFrom integerValue]){
        [self refreshViewShowInfo];
    }

}
-(void)leftBarButtonItemAction{
    
}
-(void)rightBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == RIGHTBTN_CALENDAR){
        if (!isShowDataPicker){
                [UIView animateWithDuration:.5 animations:^{
                    _datePickerBackView.transform = CGAffineTransformMakeTranslation(0, -datePickerHight- TOOLBARHEIGHT) ;
                }];
        }
    }
    else if (btn.tag == RIGHTBTN_ADD)
    {
        AddNewInOrOutViewController *anioV = [[AddNewInOrOutViewController alloc]init];
        anioV.delegate = self;
        [self.navigationController pushViewController:anioV animated:YES];
        
    }
}
-(void)editViewControllerAction{
    [self reloadViewBySelf];
}
-(void)reloadViewBySelf{
    curDateArray = [self getDataArrayFromDataBase:curDate];
    [detailViewCur loadFromDta:curDateArray];
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
