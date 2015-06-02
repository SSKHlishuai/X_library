//
//  XOwnTextfield.h
//  Xlibrary
//
//  Created by wgl7569 on 4/24/15.
//  Copyright (c) 2015 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyBlockShowResult) (NSString *);
@interface XOwnTextfield : UIView
@property (nonatomic , strong) MyBlockShowResult myBlock;
@property (nonatomic ,readonly) NSMutableString *curInPutValueStr;


@end
