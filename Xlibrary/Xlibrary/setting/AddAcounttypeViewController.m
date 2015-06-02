//
//  AddAcounttypeViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/25.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AddAcounttypeViewController.h"

@interface AddAcounttypeViewController ()<UIAlertViewDelegate>
{
    UITextView *_myTView;
    NSString *_nameStr;
    NSInteger   currentType;
}
@end

@implementation AddAcounttypeViewController

-(id)initWithType:(NSInteger)type withStr:(NSString*)nameStr
{
    self= [super init];
    if(self)
    {
        currentType=type;
        _nameStr = nameStr;
        if(type == 0)
        {
            //新de
            [self InitilizeTView];

            
        }
        else
        {
            [self NameStr:nameStr];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.middleTitle = @"新增账户";
    [self createRightBtn];
    self.view.backgroundColor = HexRGB(SSSColor);
    
    
    
    
    // Do any additional setup after loading the view.
}


-(void)NameStr:(NSString *)nameStr
{
    [self InitilizeTView];
    _myTView.text = nameStr;
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = FRAME(20, NavaStatusHeight+20+200+20, kScreenWidth-40, 40);
    deleteBtn.backgroundColor = HexRGB(0xff6347);
    [deleteBtn setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除账户" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
}


#pragma mark - SET CONTROLS

-(void)createRightBtn
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = FRAME(kScreenWidth-60, 20+5, 50, 34);
    
    [rightButton setTitle:@"存储" forState:UIControlStateNormal];
    rightButton.backgroundColor= HexRGB(LINE_COLOR);
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.headView addSubview:rightButton];
    
    
    [rightButton addTarget:self action:@selector(saveToPlist) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)InitilizeTView
{
    _myTView = [[UITextView alloc]initWithFrame:FRAME(20, NavaStatusHeight+20, kScreenWidth-40.f, 200.f)];
    _myTView.layer.borderColor = [HexRGB(0x333333)CGColor];
    _myTView.layer.borderWidth = 0.5f;
    _myTView.backgroundColor = HexRGB(0xffffff);
    [self.view addSubview:_myTView];
    
    [_myTView becomeFirstResponder];
}


#pragma mark - Actions

-(void)deleteClick
{
    NSMutableDictionary *accounttypedict = [NSMutableDictionary dictionaryWithContentsOfFile:ACCOUNT_TYPE_PATH];
    [accounttypedict removeObjectForKey:_nameStr];
    
    
    [accounttypedict writeToFile:ACCOUNT_TYPE_PATH atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)saveToPlist
{
    
    
    if(currentType==0)
    {
        NSDictionary *accounttypedict = [NSDictionary dictionaryWithContentsOfFile:ACCOUNT_TYPE_PATH];
        
        [accounttypedict setValue:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"gesture",@"0",@"isGestureOn",@"0",@"isBudgetOn",@"1",@"budget",@"on",@"isCanDelete", nil] forKey:_myTView.text];
        
        
        [accounttypedict writeToFile:ACCOUNT_TYPE_PATH atomically:YES];

    }
    else
    {
        if(![_nameStr isEqualToString:_myTView.text])
        {
            NSMutableDictionary *accounttypedict = [NSMutableDictionary dictionaryWithContentsOfFile:ACCOUNT_TYPE_PATH];
            [accounttypedict setValue:[accounttypedict objectForKey:_nameStr] forKey:_myTView.text];
            [accounttypedict removeObjectForKey:_nameStr];
            [accounttypedict writeToFile:ACCOUNT_TYPE_PATH atomically:YES];

        }
    }
    
    
    UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"是否设定为预设账户" message:@"" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    
    [myalert show];
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
    }
    else
    {
        //存为预设账户
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
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
