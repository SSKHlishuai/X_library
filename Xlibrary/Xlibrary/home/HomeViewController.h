//
//  HomeViewController.h
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewInOrOutViewController.h"
#import "DetailView.h"
#import "EditViewController.h"
#import "DateModel.h"
@interface HomeViewController : UIViewController<UIScrollViewDelegate,addNewInOrOutDelegate,DetailViewDelegate,editViewControllerDelegate>
@property (nonatomic , assign) SpendOrIncome stypeSpendOrIncome;
@end
