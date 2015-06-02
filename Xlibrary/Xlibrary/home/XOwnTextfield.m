//
//  XOwnTextfield.m
//  Xlibrary
//
//  Created by wgl7569 on 4/24/15.
//  Copyright (c) 2015 mc. All rights reserved.
//

#import "XOwnTextfield.h"
#define KEYBOARD_HEIGHT self.width
#define KEYBTN_WITH self.width/4
#define KEYBTN_HEIGHT KEYBTN_WITH/4*3
typedef enum{
    KEYBOARD_CHU = 1000,
    KEYBOARD_CHENG,
    KEYBOARD_JIAN,
    KEYBOARD_DIAN =1012,
    KEYBOARD_ZERO,
    KEYBOARD_CAN = 1014,
    KEYBOARD_JIA =1015,
    KEYBOARD_AC = 1016,
    KEYBOARD_OK = 0117
}KeyBoard_Model ;
@interface TextFieldModel : NSObject
@property (nonatomic, strong) NSString *lastValueStr;
@property (nonatomic, strong) NSMutableString *curValueStr;
@property (nonatomic ,assign) KeyBoard_Model model;
-(void)calculationWithVlaue:(NSString *)str;
@end
@implementation TextFieldModel
-(id)init{
    if (self = [super init]){
        
    }
    return self;
}
-(void)calculationWithVlaue:(NSString *)str{
    
}
-(void)setLastValueStr:(NSString *)lastValueStr{
    if (_lastValueStr) {
        
    }
}
@end
@implementation XOwnTextfield
{
    UIView *_backView;
    NSArray *_keyArray;
    TextFieldModel *textFieldModel;
    UITextField *_mainTextField;
    
}
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        textFieldModel = [[TextFieldModel alloc]init];
        _curInPutValueStr = [NSMutableString string];
        _keyArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@"", nil];
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.width, KEYBOARD_HEIGHT/4*3)];
        [_backView setBackgroundColor:COLOR_DIFFERENT_VAULE(221, 59, 59)];
        [self loadKeyBoardView];
        _mainTextField = [[UITextField alloc]init];
        _mainTextField.frame = self.bounds;
         _mainTextField.textAlignment = NSTextAlignmentRight;
        _mainTextField.text = @"￥0";
        _mainTextField.textColor = [UIColor whiteColor];
        _mainTextField.font = [UIFont systemFontOfSize:35 weight:1];
        _mainTextField.inputView = _backView;
        UIView *rightView = [[UIView alloc]initWithFrame:FRAME(0, 0, 10, 10)];
        _mainTextField.rightView=rightView;
        _mainTextField.rightViewMode = UITextFieldViewModeAlways;
        _mainTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_mainTextField];
        self.backgroundColor = COLOR_DIFFERENT_VAULE(221, 59, 59);
        _backView.userInteractionEnabled = YES;
    }
    return self;
}
-(void)selfLabelActionController{
   }
-(void)hidenTheKeyboard{
   // _myBlock(_curInPutValueStr);
    [_mainTextField resignFirstResponder];
}
-(UIButton *)createButtonWithImage:(NSString *)image title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:COLOR_DIFFERENT_VAULE(88, 88, 98) forState:UIControlStateNormal];
    if (image)
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:COLOR_DIFFERENT_VAULE(251, 250, 229)];
    [btn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.showsTouchWhenHighlighted = YES;
    return btn;
    
}
-(void)loadKeyBoardView{
    
    for (int i = 0;i < [_keyArray count]; i++){
        UIButton *keyBtn = [self createButtonWithImage:nil title:_keyArray[i]];
        keyBtn.frame = CGRectMake(i%3*KEYBTN_WITH, i/3*KEYBTN_HEIGHT,KEYBTN_WITH, KEYBTN_HEIGHT);
        keyBtn.tag = KEYBOARD_CHU + i;
        [_backView addSubview:keyBtn];
    }
//    UIButton *AddBtn = [self createButtonWithImage:nil title:@"+"];
//    AddBtn.frame = CGRectMake(KEYBTN_WITH*3, 0, KEYBTN_WITH, KEYBTN_HEIGHT);
//    AddBtn.tag = KEYBOARD_JIA;
//    [_backView addSubview:AddBtn];
//    
    UIButton *acBtn = [self createButtonWithImage:nil title:@"AC"];
    acBtn.frame = CGRectMake(KEYBTN_WITH*3, 0, KEYBTN_WITH, KEYBTN_HEIGHT*2);
    [acBtn setBackgroundColor:[UIColor redColor]];
    acBtn.tag = KEYBOARD_AC;
    [_backView addSubview:acBtn];
    
    
    UIButton *okdBtn = [self createButtonWithImage:nil title:@"OK"];
    okdBtn.frame = CGRectMake(KEYBTN_WITH*3, KEYBTN_HEIGHT*2, KEYBTN_WITH, KEYBTN_HEIGHT*2);
    [okdBtn setBackgroundColor:[UIColor greenColor]];
    okdBtn.tag = KEYBOARD_OK;
    [_backView addSubview:okdBtn];
}
-(void)keyboardAction:(UIButton *)sender{
    switch (sender.tag) {
//        case KEYBOARD_JIA:
//        {
//           
//            break;
//        }
//        case KEYBOARD_JIAN:{
//            break;
//  
//        }
//        case KEYBOARD_CHENG:{
//            break;
//
//        }
//        case KEYBOARD_CHU:{
//            break;
//
//        }
        case KEYBOARD_AC:{
            [_curInPutValueStr deleteCharactersInRange:NSMakeRange(0, [_curInPutValueStr length])];
            _mainTextField.text = @"￥0";
//            _myBlock(@"");
            break;
  
        }
        case KEYBOARD_OK:{
            [self hidenTheKeyboard];
            break;
        }
        case KEYBOARD_DIAN:{
            [self setMainLabel:sender.currentTitle];
            break;
        }
        case KEYBOARD_ZERO:{
            [self setMainLabel:sender.currentTitle];
            break;
        }
        default:{
            [self setMainLabel:sender.currentTitle];
            break;
        }
            
    }
}
char *int2str_withcommas(long number){
    char *result_str = (char *)malloc(sizeof(char)*20);
    
    int iNumCount = 0,iComma = 0,iStrlen = 0,iHead = 0;    //iNumCount是数字个数，iComma是逗号个数，iStrlen是字符串长度，不包括结尾空格，iHead是结头位置
    long fabsNumber = fabs(number);                                     //取绝对值便于处理。
    long tmp = fabsNumber;
    
    //计算数字的个数
    while (tmp > 0) {
        tmp /= 10;
        iNumCount ++;
    }
    
    //计算需要多少个逗号
    iComma= (iNumCount-1)/3;
    
    //计算字符串长度
    if (number < 0) {
        iStrlen = iNumCount + 1 + iComma;
        result_str[0] = '-';
    }else iStrlen = iNumCount + iComma;
    
    //每三位为一块，iHead是每块头位置的字符位置(倒序）
    //并且在字符串后边补上'\0'
    iHead = iStrlen;
    result_str[iStrlen] = '\0';
    
    //关键部分
    while (iStrlen >= 1&&fabsNumber >0) {
        if ((iHead-iStrlen) ==3) {
            result_str[iStrlen-1] = ',';
            iStrlen--;
            iHead -=4;
        }
        result_str[iStrlen-1] = fabsNumber%10 + '0';
        fabsNumber /= 10;
        iStrlen --;
    }
    return result_str;
}
-(void)setMainLabel:(NSString *)str {
    NSString *curLableStr = _mainTextField.text;
    if ([curLableStr hasSuffix:@"0"] && [curLableStr length] == 2 && ![str isEqualToString:@"."]){
        if (![str isEqualToString:@"0"]){
            [_curInPutValueStr appendString:str];
        }
    }
    else{
        NSRange dianRange = [curLableStr rangeOfString:@"."];
        if (dianRange.location != NSNotFound){
            if ([str isEqualToString:@"."]){
                return;
            }
            else{
                NSString *tempStr = [_mainTextField.text substringFromIndex:dianRange.location+1];
                if ([tempStr length] >= 2){
                    return;
                }
            }

        }
        if ([_curInPutValueStr length ]>9){
            return;
        }
        [_curInPutValueStr appendString:str];
    }
    if ([_curInPutValueStr rangeOfString:@"."].location != NSNotFound){
        NSArray *array = [_curInPutValueStr componentsSeparatedByString:@"."];
        NSString *str1 = [NSString stringWithFormat:@"%s",int2str_withcommas([[array objectAtIndex:0] longLongValue])];
        curLableStr = [NSString stringWithFormat:@"%@.%@",str1,[array objectAtIndex:1]];
    }
    else{
        curLableStr = [NSString stringWithFormat:@"%s",int2str_withcommas([_curInPutValueStr longLongValue])];
        
    }
    _mainTextField.text = [NSString stringWithFormat:@"￥%@",curLableStr];
//    textFieldModel.curValueStr  = _curInPutValueStr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
