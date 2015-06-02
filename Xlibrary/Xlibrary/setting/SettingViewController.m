//
//  SettingViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "SettingViewController.h"
#import "SetBudgetViewController.h"
#import "AccountTypeViewController.h"
#import "ManageTypeViewController.h"
#import "GesturePwdViewController.h"
#import "AboutViewController.h"


@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableview;
    UISwitch *myswitch;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self InitilizeTable];
    self.view.backgroundColor= HexRGB(SSSColor);
    [self hideBackbutton];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_myTableview reloadData];
    
}

-(void)InitilizeTable
{
    _myTableview = [[UITableView alloc]initWithFrame:FRAME(0, NavaStatusHeight, kScreenWidth, kScreenHeight-NavaStatusHeight) style:UITableViewStylePlain];
    _myTableview.delegate=self;
    _myTableview.dataSource=self;
    _myTableview.backgroundColor =HexRGB(SSSColor);
    _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableview];
}


#pragma mark - Actions
-(void)switchChange:(UISwitch*)switchB
{
    NSLog(@"%d",switchB.on);
    if(switchB.on == 0)
    {
        GesturePwdViewController *gestureV= [[GesturePwdViewController alloc]initWithType:2];
        [self.navigationController pushViewController:gestureV animated:YES];

    }
    else if (switchB.on==1)
    {
        GesturePwdViewController *gestureV= [[GesturePwdViewController alloc]initWithType:1];
        [self.navigationController pushViewController:gestureV animated:YES];

    }
    else
    {
        
    }
    
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"settingCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.contentView.backgroundColor = HexRGB(SSSColor);
        UIView *lineview = [[UIView alloc]initWithFrame:FRAME(0, 54.5, kScreenWidth, 0.5)];
        lineview.backgroundColor = HexRGB(LINE_COLOR);
        [cell.contentView addSubview:lineview];
    }
    
    
    
    switch (indexPath.row) {
        case 0:
        {
            cell.imageView.image = IMAGE_NAMED(@"icon_setting_budget");
            cell.textLabel.text = @"预算编列";
            break;
        }
        case 1:
        {
            cell.imageView.image = IMAGE_NAMED(@"icon_setting_account");
            cell.textLabel.text = @"账户管理";
            
            break;
        }
        case 2:
        {
            if(!myswitch)
            {
                myswitch = [[UISwitch alloc]initWithFrame:FRAME(kScreenWidth-80, 25/2.f, 60, 30)];
                [myswitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];

            }
            if([[AppUserInfor getInstanceUser].isOnPwd isEqualToString:@"NO"])
            {
                myswitch.on=NO;

            }
            else
            {
                myswitch.on=YES;
            }
            [cell.contentView addSubview:myswitch];
            
            cell.imageView.image = IMAGE_NAMED(@"icon_setting_password");
            cell.textLabel.text = @"密码设定";
            break;
        }
        case 3:
        {
            cell.imageView.image = IMAGE_NAMED(@"icon_setting_category");
            cell.textLabel.text = @"类别管理";
            break;
        }
        case 4:
        {
            cell.imageView.image = IMAGE_NAMED(@"icon_setting_fiec");
            cell.textLabel.text = @"关于我们";
            break;
        }
        default:
            break;
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            SetBudgetViewController *setbudget = [[SetBudgetViewController alloc]init];
            [self.navigationController pushViewController:setbudget animated:YES];
            
            break;
        }
        case 1:
        {
            AccountTypeViewController *account = [[AccountTypeViewController alloc]init];
            [self.navigationController pushViewController:account animated:YES];
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:
        {
            ManageTypeViewController *manavc = [[ManageTypeViewController alloc]init];
            [self.navigationController pushViewController:manavc animated:YES];
            break;
        }
        case 4:
        {
            AboutViewController *aboutV = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:aboutV animated:YES];
            break;
        }
            
        default:
            break;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
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
