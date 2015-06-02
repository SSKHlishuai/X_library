//
//  EditViewController.h
//  Xlibrary
//
//  Created by wgl7569 on 15-5-12.
//  Copyright (c) 2015年 mc. All rights reserved.
//
#import "AddNewInOrOutViewController.h"

@protocol editViewControllerDelegate <NSObject>
-(void)editViewControllerAction;
@end
#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController <addNewInOrOutDelegate>
@property (weak, nonatomic)  XPIModel *dataModel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *freLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleButton;
@property (weak, nonatomic) id <editViewControllerDelegate>delegate;


@end
