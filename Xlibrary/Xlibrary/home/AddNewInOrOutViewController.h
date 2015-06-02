//
//  AddNewInOrOutViewController.h
//  Xlibrary
//
//  Created by wgl7569 on 4/24/15.
//  Copyright (c) 2015 mc. All rights reserved.
//
@protocol addNewInOrOutDelegate <NSObject>

-(void)reloadViewBySelf;

@end
#import <UIKit/UIKit.h>
#import "DescriptionViewController.h"
#import "ShowDetailMessageViewBase.h"

@interface AddNewInOrOutViewController : UIViewController<DescriptionDelegte>
@property (nonatomic , weak)id <addNewInOrOutDelegate> delegate;
@end
