//
//  ShowDetailMessageViewBase.h
//  Xlibrary
//
//  Created by wgl7569 on 15-5-6.
//  Copyright (c) 2015年 mc. All rights reserved.
//
typedef void(^showDetialHandler)(NSInteger i);
#import <UIKit/UIKit.h>

@interface ShowDetailMessageViewBase : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) UIView *alertView;
@property (nonatomic , strong) UIView *coverView;
@property (nonatomic , copy) showDetialHandler action;
@property (nonatomic , assign) NSInteger selectIndex;
-(instancetype)initWithTitle:(NSString *)title
                     message:(NSArray *)date;
- (void)show ;
- (void)dismiss ;
@end
