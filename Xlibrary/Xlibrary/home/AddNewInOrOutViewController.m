//
//  AddNewInOrOutViewController.m
//  Xlibrary
//
//  Created by wgl7569 on 4/24/15.
//  Copyright (c) 2015 mc. All rights reserved.
//
enum{
    BTN_Description,
    BTN_Account,
    BTN_Fre
};
@interface MyButton : UIButton
@property (nonatomic , strong) UILabel *mainLabel;
@property (nonatomic , strong) UILabel *subLabel;
@property (nonatomic , strong) UIImageView *leftIamgeView;
@end
@implementation MyButton
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self loadSubView];
    }
    return self;
}
-(void)loadSubView{
    _leftIamgeView = [[UIImageView alloc]init];
    _leftIamgeView.frame = CGRectMake(5, 5,self.height - 10, self.height - 10);
    [self addSubview:_leftIamgeView];
    
    
    _mainLabel  =[[ UILabel alloc]init];
    _mainLabel.frame = CGRectMake(self.width-100, self.height/2-20, 100, 20);
    [self addSubview:_mainLabel];
    
    _subLabel  =[[UILabel alloc]init];
    _subLabel.textAlignment = NSTextAlignmentCenter;
    _subLabel.font = [UIFont systemFontOfSize:13];
    _subLabel.textColor = [UIColor grayColor];
    _subLabel.frame = CGRectMake(self.width-200-10, _mainLabel.bottomY, 200, 20);
    [self addSubview:_subLabel];
}
@end
#import "AddNewInOrOutViewController.h"
#import "XOwnTextfield.h"
#import "DetailSelectview.h"




@interface AddNewInOrOutViewController ()
{
    NSString *amountStr;
    DetailSelectview *detailSelectView;
    MyButton *desBtn;
    ShowDetailMessageViewBase *showView;
    MyButton *freBtn ;
    MyButton *accBtn;
    NSArray *freArray;
    XOwnTextfield *xot;
}

@property (nonatomic,strong)NSString *createtime;//创建时间
//@property (nonatomic,strong)NSString *cyear;     //创建年
//@property (nonatomic,strong)NSString *cmonth;     //创建月
//@property (nonatomic,strong)NSString *cday;     //创建天
@property (nonatomic,strong)NSString *typestr;  //类型
@property (nonatomic,strong)NSString *spendcount;//金额
@property (nonatomic,strong)NSString *describe;  //描述
@property (nonatomic,assign)Cycle_type type;      //无 日月天
@property (nonatomic,strong)NSString *spendorincome;//输入 or 支出
@end

@implementation AddNewInOrOutViewController
-(NSString *)createtime{
    if (!_createtime){
        _createtime = [NSString string];
    }
    return _createtime;
}
-(NSString *)spendcount{
    if (!_spendcount){
        _spendcount = [NSString string];
    }
    return _spendcount;
}
-(NSString *)describe{
    if (!_describe){
        _describe = [NSString string];
    }
    return _describe;
}
-(NSString *)typestr{
    if (!_typestr){
        _typestr = [NSString string];
    }
    return _typestr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    freArray = [NSArray arrayWithObjects:@"无",@"每日",@"每周",@"每月", nil];
    self.view.backgroundColor  = COLOR_DIFFERENT_VAULE(234, 231, 200);
    amountStr  = [NSString string];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    xot = [[XOwnTextfield alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    detailSelectView = [[DetailSelectview alloc]initWithFrame:CGRectMake(0, xot.bottomY, kScreenWidth, 0)];
    [self.view addSubview:detailSelectView];
    [self.view addSubview:xot];
    
    desBtn = [[MyButton alloc]initWithFrame:CGRectMake(0, detailSelectView.bottomY, kScreenWidth, 60)];
    desBtn.mainLabel.text = @"描述";
    desBtn.layer.borderWidth = .5;
    desBtn.layer.borderColor = COLOR_DIFFERENT_VAULE(196, 195, 179).CGColor;
    [desBtn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    [desBtn addTarget:self action:@selector(myBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [desBtn.leftIamgeView setImage:[UIImage imageNamed:@"description icon"]];
    desBtn.tag = BTN_Description;
    [self.view addSubview:desBtn];
    
    accBtn = [[MyButton alloc]initWithFrame:CGRectMake(0, desBtn.bottomY-1, kScreenWidth, 60)];
    accBtn.mainLabel.text = @"账户";
    accBtn.layer.borderWidth = .5;
    [accBtn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchDown];
    [accBtn addTarget:self action:@selector(myBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [accBtn.leftIamgeView setImage:[UIImage imageNamed:@"account icon"]];
    accBtn.tag = BTN_Account;
    accBtn.layer.borderColor = COLOR_DIFFERENT_VAULE(196, 195, 179).CGColor;
    [self.view addSubview:accBtn];
    
    freBtn = [[MyButton alloc]initWithFrame:CGRectMake(0, accBtn.bottomY-1, kScreenWidth, 60)];
    freBtn.mainLabel.text = @"固定支出";
    freBtn.subLabel.text = @"无";
    freBtn.layer.borderWidth = .5;
    [freBtn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    [freBtn addTarget:self action:@selector(myBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [freBtn.leftIamgeView setImage:[UIImage imageNamed:@"routine expense icon"]];
    freBtn.tag = BTN_Fre;
    freBtn.layer.borderColor = COLOR_DIFFERENT_VAULE(196, 195, 179).CGColor;
    [self.view addSubview:freBtn];
    self.type = CYCLE_NONE;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"储存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
        // Do any additional setup after loading the view.
}
-(void)saveAction:(UIButton *)sender{
    if(!xot.curInPutValueStr){
        return;
    }
    if (!detailSelectView.typeTag){
        return;
    }
    
#warning 存入数据库
    XPIModel *model = [[XPIModel alloc]init];
    NSString *str = @"";
    model.createtime = [NSString returnCreateTime:[NSDate date]];
    model.typestr = NSStringFormat(detailSelectView.typeTag);
    model.describe = desBtn.subLabel.text;
    model.spendcount = xot.curInPutValueStr;
    model.spendorincome = @"spend";
    NSLog(@"%@",freBtn.subLabel.text);
    model.type = [NSString stringWithFormat:@"%ld",[Help getType:freBtn.subLabel.text]];
    model.cyear = [NSString year:[NSDate date]];
    model.cmonth = [NSString month:[NSDate date]];
    model.cday = [NSString day:[NSDate date]];
    [[XDatabase shareInstance]insertPIDataWithModel:model];
    [_delegate reloadViewBySelf];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)downAction:(UIButton *)sender{
    
    [sender setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.1]];
}
-(void)myBtnAction:(UIButton *)sender{
    [sender setBackgroundColor:[UIColor clearColor]];
    if (sender.tag == BTN_Description){
        DescriptionViewController *dsv = [[DescriptionViewController alloc]init];
        dsv.contText = desBtn.subLabel.text;
        dsv.delegate = self;
        [self.navigationController pushViewController:dsv animated:YES];
    }
    else if (sender.tag == BTN_Account){
        showView = [[ShowDetailMessageViewBase alloc]initWithTitle:@"请选取账户" message:@[@"现金账户"]];
        showView.action = ^(NSInteger i){
           
        };
        [showView show];
    }
    else if (sender.tag == BTN_Fre){
        showView = [[ShowDetailMessageViewBase alloc]initWithTitle:@"请选取自动输入之周期" message:freArray];
        __weak id tSelf = self;
        showView.action = ^(NSInteger i){
            [tSelf freSetWithSelect:i];
        };
        [showView show];
    }
    
}
-(void)freSetWithSelect:(NSInteger)i{
    freBtn.subLabel.text = [freArray objectAtIndex:i-1];
    self.type = (Cycle_type)i-1;
}
-(void)log:(NSString *)str{
    amountStr = str;
    NSLog(@"%@",amountStr);
}
-(void)setDescriptionWith:(NSString *)str{
    desBtn.subLabel.text = str;
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
