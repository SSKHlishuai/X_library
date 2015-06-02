//
//  PwdCollectionV.h
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PwdCollectionViewDelegate.h"
@interface PwdCollectionV : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,assign)id<PwdCollectionViewDelegate>_myDelegate;

@end
