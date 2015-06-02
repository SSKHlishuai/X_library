//
//  EditViewController.m
//  Xlibrary
//
//  Created by wgl7569 on 15-5-12.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "EditViewController.h"
@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editBtnAction)];
    
    NSString *imageStr =[NSString stringWithFormat:@"%@-w",[Help getImageName:self.dataModel]];
    [self.typeImageView setImage:IMAGE_NAMED(imageStr)];
    self.typeLabel.text = [Help getTypeChineseName:self.dataModel];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.dataModel.spendcount];
    self.accountLabel.text = self.dataModel.accoutTypestr;
    self.desLabel.text = self.dataModel.describe;
    self.dateLabel.text = [NSString stringWithFormat:@"%@/%@/%@",self.dataModel.cyear,self.dataModel.cmonth,self.dataModel.cday];
    // Do any additional setup after loading the view from its nib.

}
-(IBAction)deleteButton:(id)sender{
    [[XDatabase shareInstance]deleteData:self.dataModel];
    [_delegate editViewControllerAction];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editBtnAction{
    AddNewInOrOutViewController *advioov = [[AddNewInOrOutViewController alloc]init];
    [self.navigationController pushViewController:advioov animated:YES];
    advioov.delegate = self;
    
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
