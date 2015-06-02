//
//  UIBarButtonItem+Ext.h
//  Xlibrary
//
//  Created by mc on 15/4/24.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Ext)
+(UIBarButtonItem *)itemWithImageName:(NSString *)ImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
