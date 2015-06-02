//
//  ShowDetailMessageView.m
//  Xlibrary
//
//  Created by wgl7569 on 15-5-6.
//  Copyright (c) 2015年 mc. All rights reserved.
//
@interface MyTableCell : UITableViewCell
@property (nonatomic,strong)UIImageView *selectImage;
- (void)setBackLabelWithTile:(NSString *)str withW:(CGFloat)w;

@end
@implementation MyTableCell
{
    UILabel *_backLabel;
}
-(id)init{
    if (self = [super init]){
        [self buildViews];
    }
    return self;
}
-(void)buildViews{
    _backLabel = [[UILabel alloc]init];
    _backLabel.frame = self.bounds;
    [_backLabel setBackgroundColor: COLOR_DIFFERENT_VAULE(234, 231, 200)];
    XLog(@"%@",NSStringFromCGRect(self.bounds));
    _backLabel.textAlignment = NSTextAlignmentCenter;
    _backLabel.layer.borderColor = COLOR_DIFFERENT_VAULE(196, 195, 179).CGColor;
    _backLabel.layer.borderWidth = .5;
    [self addSubview:_backLabel];
    _selectImage = [[UIImageView alloc]initWithImage:IMAGE_NAMED(@"check")];
}
- (void)setBackLabelWithTile:(NSString *)str withW:(CGFloat)w{
    _backLabel.text = str;
    _backLabel.font = [UIFont systemFontOfSize:13];
    _backLabel.frame = CGRectMake(0, 0, w, self.height);
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _selectImage.frame = CGRectMake((w-size.width)/2-20,(self.height-13)/2, 13, 13);
    _selectImage.hidden = YES;
    [self addSubview:_selectImage];
}
@end
#define AlertWidth kScreenWidth/4*3
#define AlertHeight kScreenHeight/4*3
#import "ShowDetailMessageViewBase.h"
@implementation ShowDetailMessageViewBase{
    NSArray *dateAray;
    NSString *titleStr;
    UIView *contView;
}
- (instancetype)init{
    self = [super init];
    if (self){
        self.frame = [self screenBounds];
        _coverView = [[UIView alloc]initWithFrame:[self topView].bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [[self topView] addSubview:_coverView];
        
        
        _alertView = [[UIView alloc]init ];
        _alertView.layer.cornerRadius = 5;
        _alertView.layer.masksToBounds = YES;
        _alertView.backgroundColor = [UIColor clearColor];
        _alertView.clipsToBounds =  NO;
        [self addSubview:_alertView];
        
        contView = [[UIView alloc]init];
        [_alertView addSubview:contView];
        
        UIButton *extBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [extBtn setBackgroundImage:[UIImage imageNamed:@"deleteIconTap"] forState:UIControlStateNormal];
        [extBtn setBackgroundImage:[UIImage imageNamed:@"deleteIconTap"] forState:UIControlStateHighlighted];
        extBtn.frame = CGRectMake(_alertView.width-34, 0, 34, 34);
        [extBtn setBackgroundColor:HexRGB(0xfcfcea)];
        extBtn.layer.cornerRadius = 17.0f;
        [extBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:extBtn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title
                     message:(NSArray *)date{
    self = [self init];
    if (self){
        dateAray = date;
        titleStr = title;
        [self buildView];
    }
    return self;
}
- (instancetype)initWithBtnArray:(NSArray *)btnArray
{
    self = [self init];
    if (self){
        [self buildWithBtnArray:btnArray];
    }
    return self;
}
-(void)buildWithBtnArray:(NSArray *)btnArray{
    _alertView.frame = CGRectMake(0, 0, kScreenWidth - 40 , kScreenHeight/2);
    _alertView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    for (int i = 0;i < [dateAray count]; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[dateAray objectAtIndex:i] forState:UIControlStateNormal];
#warning 写到这里 ………………
        
    }
}
- (CGRect)screenBounds
{
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        return CGRectMake(0, 0, kScreenWidth ,kScreenHeight);
}

-(void)buildView{
    _alertView.frame = CGRectMake(0, 0, AlertWidth, AlertHeight);
    _alertView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    contView.frame = CGRectMake(17, 17, _alertView.width - 34, _alertView.height - 34);

    UITableView *contTableView = [[UITableView alloc]initWithFrame:contView.bounds style:UITableViewStylePlain];
    contTableView.delegate = self;
    contTableView.dataSource = self;
    contTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contTableView.backgroundColor = COLOR_DIFFERENT_VAULE(234, 231, 200);
    [contView addSubview:contTableView];
    
}

#pragma mark  ----- tableViewDelgate begin---------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dateAray count]+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"cll";
    MyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell){
        cell = [[MyTableCell alloc]init];
        if(indexPath.row == 0){
            [cell setBackLabelWithTile:titleStr withW:AlertWidth-34];
        }
        else{
            [cell setBackLabelWithTile:[dateAray objectAtIndex:indexPath.row-1] withW:AlertWidth - 34];
        }
        if (indexPath.row == _selectIndex + 1){
            cell.selectImage.hidden  = NO;
        }
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0){
        _selectIndex = indexPath.row - 1;
        [tableView reloadData];
        _action(indexPath.row);
        [self dismiss];
    }
}
#pragma mark  ----- tableViewDelgate end---------
-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window.subviews[0];
}
- (void)show {
    [UIView animateWithDuration:0.5 animations:^{
        _coverView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [[self topView] addSubview:self];
    [self showAnimation];
}

- (void)dismiss {
    [self hideAnimation];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //    [self removeFromSuperview];
}

- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_alertView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        _coverView.alpha = 0.0;
        _alertView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
