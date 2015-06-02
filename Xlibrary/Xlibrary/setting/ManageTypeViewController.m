//
//  ManageTypeViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "ManageTypeViewController.h"
#import "ManageAddTypeVController.h"
#import "IncomeTable.h"
#import "SpendTable.h"






typedef enum
{
    Select_type_spend=0,
    Select_type_income
}Select_type;


@interface ManageTypeViewController ()
{
    IncomeTable *incometable;
    SpendTable *spendtable;
    Select_type   currentSelect;
    
    UIButton    *spendBtn;
    UIButton    *incomeBtn;
    
    UIButton    *_bottomBtn;
}
@end

@implementation ManageTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= HexRGB(SSSColor);
    [self createTwoBtn];
    [self createTableView];
    [self createBottomButton];
    currentSelect = Select_type_spend;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(currentSelect == Select_type_spend)
    {
        [spendtable getLocalData];
    }
    else
    {
        [incometable getLocalData];
    }
}


#pragma mark - InitilizeTable

-(void)createBottomButton
{
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.frame = FRAME(0, kScreenHeight-49, kScreenWidth, 49);
    _bottomBtn.backgroundColor = HexRGB(0x333333);
    [_bottomBtn setImage:IMAGE_NAMED(@"add icon") forState:UIControlStateNormal];
    [_bottomBtn setImage:IMAGE_NAMED(@"add icon tap") forState:UIControlStateHighlighted];
    _bottomBtn.imageView.contentMode = UIViewContentModeCenter;
    [_bottomBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn addTarget:self action:@selector(addDownClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_bottomBtn];
}
- (void)createTwoBtn
{
    int width = kScreenWidth/2;

//f5f5dc
    spendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    spendBtn.frame = FRAME(0, NavaStatusHeight, width, 43.5);
    spendBtn.backgroundColor = HexRGB(0xf5f5dc);
    [spendBtn setTitleColor:HexRGB(0x636363) forState:UIControlStateNormal];
    [spendBtn setTitle:@"支出" forState:UIControlStateNormal];
    spendBtn.tag = 101;
    [spendBtn addTarget:self action:@selector(btnLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spendBtn];
    
    incomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    incomeBtn.frame = FRAME(width, NavaStatusHeight, width, 43.5);
    incomeBtn.backgroundColor = HexRGB(SSSColor);
    [incomeBtn setTitleColor:HexRGB(0x636363) forState:UIControlStateNormal];
    [incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    incomeBtn.tag = 102;
    [incomeBtn addTarget:self action:@selector(btnLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:incomeBtn];
    
    UIView *lineview = [[UIView alloc]initWithFrame:FRAME(0, incomeBtn.bottomY, kScreenWidth, 0.5)];
    lineview.backgroundColor = HexRGB(LINE_COLOR);
    [self.view addSubview:lineview];
    
    
    
    
}

#pragma mark - Actions

-(void)addClick
{
    _bottomBtn.backgroundColor = HexRGB(0x333333);
    ManageAddTypeVController *manaadd = [[ManageAddTypeVController alloc]initWithNewOrChange:Type_CA_Add WithSpendOrIncome:1];
    [self.navigationController pushViewController:manaadd animated:YES];
    
    
}

-(void)addDownClick
{
    _bottomBtn.backgroundColor = [UIColor blackColor];
}
- (void)btnLibrary:(UIButton *)bt
{
    
    if(bt.tag-101 == currentSelect)
    {
        return;
    }
    else if(bt.tag == 101)
    {
        currentSelect = Select_type_spend;
    }
    else
    {
        currentSelect = Select_type_income;
    }
    [incometable removeFromSuperview];
    [spendtable removeFromSuperview];
    
    if(currentSelect == Select_type_spend)
    {
        spendBtn.backgroundColor = HexRGB(0xf5f5dc);
        incomeBtn.backgroundColor = HexRGB(SSSColor);

    }
    else
    {
        incomeBtn.backgroundColor = HexRGB(0xf5f5dc);
        spendBtn.backgroundColor = HexRGB(SSSColor);
    }
    
    
    if(bt.tag ==Select_type_spend+101){
        if(spendtable)
        {
            [self.view addSubview:spendtable];
        }
        else
        {
            spendtable = [[SpendTable alloc]initWithFrame:FRAME(0, NavaStatusHeight+44, kScreenWidth, kScreenHeight-44-49-NavaStatusHeight) style:UITableViewStylePlain];
            spendtable.MTAdelegate=self;
            spendtable.separatorStyle = UITableViewCellSeparatorStyleNone;
            spendtable.backgroundColor = HexRGB(SSSColor);
            [self.view addSubview:spendtable];
        }
      
    }else{
        if(incometable)
        {
            [self.view addSubview:incometable];
        }
        else
        {
            incometable = [[IncomeTable alloc]initWithFrame:FRAME(0, NavaStatusHeight+44, kScreenWidth, kScreenHeight-44-NavaStatusHeight-49) style:UITableViewStylePlain];
            incometable.separatorStyle = UITableViewCellSeparatorStyleNone;
            incometable.backgroundColor = HexRGB(SSSColor);
            incometable.MTAdelegate=self;
            [self.view addSubview:incometable];
            
        }
       
    }

}

- (void)createTableView
{
    spendtable = [[SpendTable alloc]initWithFrame:FRAME(0, NavaStatusHeight+44, kScreenWidth, kScreenHeight-44-NavaStatusHeight-49) style:UITableViewStylePlain];
    spendtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    spendtable.backgroundColor = HexRGB(SSSColor);
    spendtable.MTAdelegate=self;
    [self.view addSubview:spendtable];
}



-(void)pushManageAddType:(ManageTypeModel *)model
{
    NSInteger temp1;
    if([model.typeType isEqualToString:@"spend"])
    {
        temp1 = 1;
    }
    else
    {
        temp1 = 0;
    }
    ManageAddTypeVController *manaadd = [[ManageAddTypeVController alloc]initWithNewOrChange:Type_CA_Change WithSpendOrIncome:temp1];
    manaadd.selectModel = model;
    [self.navigationController pushViewController:manaadd animated:YES];

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
