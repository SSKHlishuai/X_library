//
//  GesturePwdViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "GesturePwdViewController.h"

@interface GesturePwdViewController ()<PwdFloorViewDelegate>
{
    PwdFloorView *_myFloorPwdView;
}
@end

@implementation GesturePwdViewController


-(instancetype)initWithType:(TYPE_VerifyOrReset)verifyOrReset
{
    self = [super init];
    if(self)
    {
        [self InitilizePwdView:verifyOrReset];
        if(verifyOrReset == TYPE_VerifyOrReset_verify)
        {
            [self hideBackbutton];
        }
        

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexRGB(SSSColor);

    // Do any additional setup after loading the view.
}

-(void)deleteSuccessAndPop
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)resetSuccessAndPop
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)verifySuccessAndPop
{
    if([self.gestDelegate respondsToSelector:@selector(changeRootViewController)])
    {
        [self.gestDelegate performSelector:@selector(changeRootViewController) withObject:nil];
    }
}
-(void)InitilizePwdView:(TYPE_VerifyOrReset)verifyOrReset
{
    _myFloorPwdView = [[PwdFloorView alloc]initWithFrame:FRAME(0, NavaStatusHeight, kScreenWidth, kScreenHeight-NavaStatusHeight)withVerifyOrReset:verifyOrReset];
    _myFloorPwdView.backgroundColor = HexRGB(SSSColor);
    _myFloorPwdView.myDelegate=self;
    [self.view addSubview:_myFloorPwdView];
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
