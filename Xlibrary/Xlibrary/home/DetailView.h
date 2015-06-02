//
//  DetailView.h
//  Xlibrary
//
//  Created by wgl7569 on 15-4-20.
//  Copyright (c) 2015年 mc. All rights reserved.
//
@protocol DetailViewDelegate <NSObject>
-(void)showEditViewControllerWithDataModel:(XPIModel*)mode;
@end
#import <UIKit/UIKit.h>

@interface DetailView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , weak) id <DetailViewDelegate>delegate ;
-(void)loadFromDta:(NSArray *)array;

@end
