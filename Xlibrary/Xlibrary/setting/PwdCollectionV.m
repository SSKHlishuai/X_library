//
//  PwdCollectionV.m
//  Xlibrary
//
//  Created by mc on 15/4/28.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "PwdCollectionV.h"
#import "PwdCollectionViewCell.h"


#define PwdCollectionViewCellIdentify @"PwdCollectionViewCellIdentify"
@implementation PwdCollectionV



-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self)
    {
        [self registerClass:[PwdCollectionViewCell class] forCellWithReuseIdentifier:PwdCollectionViewCellIdentify];

        self.delegate=self;
        self.dataSource=self;
    }
    
    
    return self;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}



-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellname = PwdCollectionViewCellIdentify;
    PwdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellname forIndexPath:indexPath];
   
//    cell.backgroundView.backgroundColor = HexRGB(SSSColor);
//    cell.selectedBackgroundView.backgroundColor = HexRGB(0xe3e3e3);
    if(indexPath.item<9)
    {
        cell.titleStr = [NSString stringWithFormat:@"%ld",indexPath.item+1];

    }
    else if(indexPath.item==10)
    {
        cell.titleStr = [NSString stringWithFormat:@"0"];

    }
    else if(indexPath.item == 11)
    {
        cell.titleStr = [NSString stringWithFormat:@"%@",@"<—"];
    }
    
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/3.f, (kScreenHeight/2)/4.f);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PwdCollectionViewCell *cell = (PwdCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changeColor];
    
    if(indexPath.item<9)
    {
        if([self._myDelegate respondsToSelector:@selector(judgeGetpwdkeyboard:)])
        {
            [self._myDelegate performSelector:@selector(judgeGetpwdkeyboard:) withObject:[NSString stringWithFormat:@"%ld",indexPath.item+1]];
        }
    }
    else if(indexPath.item==10)
    {
        if([self._myDelegate respondsToSelector:@selector(judgeGetpwdkeyboard:)])
        {
            [self._myDelegate performSelector:@selector(judgeGetpwdkeyboard:) withObject:[NSString stringWithFormat:@"0"]];
        }
        
    }
    else if(indexPath.item == 11)
    {
        if([self._myDelegate respondsToSelector:@selector(judgeGetpwdkeyboard:)])
        {
            [self._myDelegate performSelector:@selector(judgeGetpwdkeyboard:) withObject:[NSString stringWithFormat:@"-1"]];
        }
    }

    
}



@end
