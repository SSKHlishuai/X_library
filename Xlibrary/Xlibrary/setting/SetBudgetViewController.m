//
//  SetBudgetViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/24.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "SetBudgetViewController.h"
#import "AKPickerView.h"


#define CANCEL_TAG 100
#define DONE_TAG    101

@interface SetBudgetViewController ()<UITextFieldDelegate,AKPickerViewDataSource,AKPickerViewDelegate>
{
    UITextField* _budgetTF;
    UIView      *freeview;
    UILabel     *_budgetLabel;
    UIView      *_bottomView;
    BOOL        isShowPicker;
    AKPickerView    *_akpickerview;
    NSInteger      _currentSelect;
}
@end

@implementation SetBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isShowPicker=NO;
    self.view.backgroundColor = HexRGB(SSSColor);
    _currentSelect = 1;
    
    
    [self InitilizeControls];
    [self InitilizeFreeview];
    // Do any additional setup after loading the view.
}

-(void)InitilizeControls
{
    _budgetTF = [[UITextField alloc]initWithFrame:FRAME(0, NavaStatusHeight, kScreenWidth,100)];

    _budgetTF.delegate=self;
    _budgetTF.backgroundColor = HexRGB(0xffa500);
    _budgetTF.textAlignment = NSTextAlignmentRight;
    _budgetTF.font = [UIFont boldSystemFontOfSize:40.f];
    _budgetTF.textColor = HexRGB(0xffffff);
    _budgetTF.text = @"RMB";
    UIView *rightView = [[UIView alloc]initWithFrame:FRAME(0, 0, 20, 1)];
    _budgetTF.rightView = rightView;
    _budgetTF.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_budgetTF];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame=  FRAME(0, _budgetTF.bottomY, kScreenWidth, 50.f);
    [topButton addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    topButton.backgroundColor = HexRGB(SSSColor);
    [self.view addSubview:topButton];
    
    //topbtn上面的视图创建
    UIImageView *leftimage = [[UIImageView alloc]initWithFrame:FRAME(10, 5, 38, 40)];
    leftimage.image = IMAGE_NAMED(@"icon_budget_date");
    leftimage.contentMode = UIViewContentModeScaleAspectFit;
    [topButton addSubview:leftimage];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:FRAME(leftimage.rightX+10, 0, 100, 49)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HexRGB(0x444444);
    label1.font = Label_font(18.f);
    label1.text = @"预算周期";
    [topButton addSubview:label1];
    
    _budgetLabel = [[UILabel alloc]initWithFrame:FRAME(kScreenWidth-150, 0, 140, 49)];
    _budgetLabel.textAlignment = NSTextAlignmentRight;
    _budgetLabel.textColor = HexRGB(0x444444);
    _budgetLabel.font = Label_font(15.f);
    _budgetLabel.text = [NSString stringWithFormat:@"起始于每月第%ld天",_currentSelect];
    [topButton addSubview:_budgetLabel];
    
    UIView *lineview2 = [[UIView alloc]initWithFrame:FRAME(0, topButton.height-0.5, kScreenWidth, 0.5)];
    lineview2.backgroundColor= HexRGB(LINE_COLOR);
    [topButton addSubview:lineview2];
    
    
    //hide view
    freeview = [[UIView alloc]initWithFrame:FRAME(0, topButton.bottomY, kScreenWidth, 110)];
    freeview.hidden=YES;
    freeview.backgroundColor = HexRGB(SSSColor);
    [self.view addSubview:freeview];
    
    
    [self InitilizeFreeview];
    
    
    
    _bottomView = [[UIView alloc]initWithFrame:FRAME(0, topButton.bottomY, kScreenWidth, 50)];
    _bottomView.backgroundColor = HexRGB(SSSColor);
    [self.view addSubview:_bottomView];
    
    [self InitilizeBottom];
    
}

-(void)InitilizeFreeview
{
    _akpickerview = [[AKPickerView alloc]initWithFrame:FRAME(0, 5, kScreenWidth, 40)];
    _akpickerview.delegate=self;
    _akpickerview.dataSource=self;
    _akpickerview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _akpickerview.hidden=YES;
    [freeview addSubview:_akpickerview];
    
    _akpickerview.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
   _akpickerview.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    _akpickerview.interitemSpacing = 20.0;
   _akpickerview.fisheyeFactor = 0.001;
    _akpickerview.pickerViewStyle = AKPickerViewStyle3D;
   _akpickerview.maskDisabled = false;
    [_akpickerview reloadData];
    
    UIButton    *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = HexRGB(0xff6347);
    cancelBtn.frame = FRAME(20, _akpickerview.bottomY+5, 120, 35);
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [freeview addSubview:cancelBtn];
    
    
    UIButton    *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.backgroundColor = HexRGB(0xb3ee3a);
    doneBtn.frame = FRAME(kScreenWidth-140, _akpickerview.bottomY+5, 120, 35);
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [freeview addSubview:doneBtn];
    
    cancelBtn.tag=CANCEL_TAG;
    doneBtn.tag=DONE_TAG;
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)InitilizeBottom
{
    UIImageView *leftimage = [[UIImageView alloc]initWithFrame:FRAME(10, 5, 38, 40)];
    leftimage.image = IMAGE_NAMED(@"icon_setting_budget");
    leftimage.contentMode = UIViewContentModeScaleAspectFit;
    [_bottomView addSubview:leftimage];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:FRAME(leftimage.rightX+10, 0, 100, 49)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HexRGB(0x444444);
    label1.font = Label_font(18.f);
    label1.text = @"显示预算";
    [_bottomView addSubview:label1];
    
    
    UISwitch *_mySwich = [[UISwitch alloc]initWithFrame:FRAME(kScreenWidth-70, 10, 80, 30)];
    [_bottomView addSubview:_mySwich];
    
    
   UIView *lineview = [[UIView alloc]initWithFrame:FRAME(0, _bottomView.height-0.5, kScreenWidth, 0.5)];
    lineview.backgroundColor= HexRGB(LINE_COLOR);
    [_bottomView addSubview:lineview];

}


#pragma mark - Actions
-(void)topBtnClick
{
    if(!isShowPicker)
    {
        isShowPicker=YES;
        
        [UIView animateWithDuration:0.5f animations:^{
            CGRect rect = _bottomView.frame;
            rect.origin.y += 110;
            _bottomView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            freeview.hidden=NO;
            _akpickerview.hidden=NO;
            
            
        }];
        
        
    }

}

-(void)btnClick:(UIButton*)button
{
    if(button.tag==CANCEL_TAG)
    {
        freeview.hidden=YES;
        _akpickerview.hidden=YES;


        [UIView animateWithDuration:0.5f animations:^{

            CGRect rect = _bottomView.frame;
            rect.origin.y -= 110;
            _bottomView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            isShowPicker=NO;

            
        }];

    }
    else if(button.tag==DONE_TAG)
    {
        freeview.hidden=YES;
        _akpickerview.hidden=YES;
        
        
        [UIView animateWithDuration:0.5f animations:^{
            
            CGRect rect = _bottomView.frame;
            rect.origin.y -= 110;
            _bottomView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            isShowPicker=NO;
            _budgetLabel.text = [NSString stringWithFormat:@"起始于每月第%ld天",_currentSelect];

            
        }];
        
        

    }
    else
    {
        
    }
}

#pragma mark - AKPickerViewDelegate
-(NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return 31;
}



-(NSString*)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return [NSString stringWithFormat:@"%ld",item+1];
}

-(void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    _currentSelect = item+1;
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
