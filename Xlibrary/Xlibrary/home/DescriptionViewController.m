//
//  DescriptionViewController.m
//  Xlibrary
//
//  Created by wgl7569 on 15-5-6.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController (){
    UITextView *textField;
}

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor  = COLOR_DIFFERENT_VAULE(234, 231, 200);
    textField = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, self.view.width-10, self.view.width)];
    textField.layer.borderColor = [HexRGB(0x333333)CGColor];
    textField.layer.borderWidth = 0.5f;
    textField.backgroundColor = HexRGB(0xffffff);
    textField.text = _contText;
    textField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:textField];
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"储存" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    // Do any additional setup after loading the view.
    
}
-(void)leftBarButtonItemAction{
    [_delegate setDescriptionWith:textField.text];
    [self.navigationController popViewControllerAnimated:YES];
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
