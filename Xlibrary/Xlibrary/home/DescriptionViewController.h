//
//  DescriptionViewController.h
//  Xlibrary
//
//  Created by wgl7569 on 15-5-6.
//  Copyright (c) 2015年 mc. All rights reserved.
//
@protocol DescriptionDelegte <NSObject>

-(void)setDescriptionWith:(NSString *)str;
@end
#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController
@property (nonatomic , strong) NSString *contText;
@property (nonatomic , unsafe_unretained) id <DescriptionDelegte>delegate;
@end
