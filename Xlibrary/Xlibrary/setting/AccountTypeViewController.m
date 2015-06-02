//
//  AccountTypeViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/25.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AccountTypeViewController.h"
#import "AccountTypeModel.h"
#import "AccountTypeCell.h"
#import "AddAcounttypeViewController.h"

@interface AccountTypeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableview;
    NSMutableArray  *_dataArray;
}
@end

@implementation AccountTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArray = [[NSMutableArray alloc]init];
    
    
    [self createRightBtn];
    [self setControls];

    
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getPlistData];

}

-(void)getPlistData
{
    [_dataArray removeAllObjects];
    NSDictionary *accounttypedict = [NSDictionary dictionaryWithContentsOfFile:ACCOUNT_TYPE_PATH];
    for(NSString *str in accounttypedict)
    {
        AccountTypeModel *model = [[AccountTypeModel alloc]initWihtDict:[accounttypedict objectForKey:str]withKey:str];
        [_dataArray addObject:model];
    }
    
    [_myTableview reloadData];
}





#pragma mark - Set Controls

-(void)setControls
{
    _myTableview = [[UITableView alloc]initWithFrame:FRAME(0, NavaStatusHeight, kScreenWidth, kScreenHeight-NavaStatusHeight) style:UITableViewStylePlain];
    _myTableview.delegate=self;
    _myTableview.dataSource=self;
    _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableview.backgroundColor= HexRGB(SSSColor);
    [self.view addSubview:_myTableview];
}

-(void)createRightBtn
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = FRAME(kScreenWidth-60, 20+5, 40, 34);
    
    [rightButton setImage:IMAGE_NAMED(@"add icon") forState:UIControlStateNormal];
    [rightButton setImage:IMAGE_NAMED(@"add icon tap") forState:UIControlStateHighlighted];
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:rightButton];
    
}

#pragma mark - Actions
-(void)rightBtnClick
{
    AddAcounttypeViewController *addacount = [[AddAcounttypeViewController alloc]initWithType:0 withStr:nil];
    [self.navigationController pushViewController:addacount animated:YES];
}



#pragma mark - UITableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"AccountCellIdentify";
    AccountTypeCell *cell = (AccountTypeCell*)[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[AccountTypeCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    
    AccountTypeModel *model = _dataArray[indexPath.row];
    cell.titleLable.text = model.accountKey;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountTypeModel *model = _dataArray[indexPath.row];

    AddAcounttypeViewController *addac = [[AddAcounttypeViewController alloc]initWithType:1 withStr:model.accountKey];
    [self.navigationController pushViewController:addac animated:NO];
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
