//
//  AboutViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSString    *versionStr;
    NSString    *phoneNumStr;
    NSString    *emailStr;
    NSString    *weixinStr;
}


@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.middleTitle = @"关于我们";
    
    [self InitilizeTable];
    self.view.backgroundColor = HexRGB(SSSColor);
    
    versionStr = @"v2.3.1";
    phoneNumStr = @"2009-099-888";
    emailStr = @"fudada@fuda.cn";
    weixinStr = @"fudada";
    [_tableView reloadData];
    // Do any additional setup after loading the view.
}

#pragma mark - Initilize controls
-(void)InitilizeTable
{
    _tableView = [[UITableView alloc]initWithFrame:FRAME(0, NavaStatusHeight, kScreenWidth, kScreenHeight-NavaStatusHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = HexRGB(SSSColor);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *head = [[UIView alloc]initWithFrame:FRAME(0, 0, kScreenWidth, 300)];
    head.backgroundColor = HexRGB(SSSColor);
    
    UIImageView *headview = [[UIImageView alloc]initWithFrame:FRAME(0, 20, kScreenWidth,200)];
    headview.image = IMAGE_NAMED(@"fiec_en_35");
    headview.contentMode = UIViewContentModeScaleAspectFit;
    [head addSubview:headview];
    
    UIView *grayView = [[UIView alloc]initWithFrame:FRAME(0, headview.bottomY+40, kScreenWidth, 40)];
    grayView.backgroundColor = HexRGB(SSSColor);
    [head addSubview:grayView];
    
    
    return head;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"aboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.contentView.backgroundColor = HexRGB(SSSColor);
        cell.backgroundColor = HexRGB(SSSColor);
    }
    
    if(indexPath.row ==0)
    {
        cell.textLabel.text = @"认识我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"版本号";
        cell.detailTextLabel.text = versionStr;
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = @"客服电话";
        cell.detailTextLabel.text = phoneNumStr;
    }
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"邮箱";
        cell.detailTextLabel.text = emailStr;
    }
    else
    {
        cell.textLabel.text = @"微信";
        cell.detailTextLabel.text = weixinStr;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 300;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
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
