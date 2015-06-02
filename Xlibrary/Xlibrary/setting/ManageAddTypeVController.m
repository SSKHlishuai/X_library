//
//  ManageAddTypeVController.m
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "ManageAddTypeVController.h"
#import "ManageTypeAddCell.h"


#define ManageAddCellIdentify @"manageAddCellIdentify"

@interface ManageAddTypeVController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_myCollectionV;
    NSMutableArray  *_dataArray;
    NSInteger   lastSelect;
    NSInteger   currentSelect;
    UIImageView     *_topImageView;
    UITextField     *_topTextField;
    Type_CA     _myCurrentType;
    NSInteger   _isSpend;
}
@end

@implementation ManageAddTypeVController

-(instancetype)initWithNewOrChange:(Type_CA)type WithSpendOrIncome:(NSInteger)Spenorincome
{
    self = [super init];
    if(self)
    {
        _myCurrentType = type;
        _isSpend = Spenorincome;
        [self InitilizeData];
        
    }
    return self;
}


-(void)InitilizeData
{
    lastSelect = -1;
    currentSelect = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.middleTitle = @"新增类别";
    self.view.backgroundColor = HexRGB(SSSColor);
    _dataArray = [[NSMutableArray alloc]init];
    [self getPlistData];
 
    [self InitilizeCollectionView];
    [self InitilizeTopView];
    [self createRightBtn];
    
    if(_myCurrentType == Type_CA_Change)
    {
        [self createDeleteButton];
    }
    // Do any additional setup after loading the view.
}

-(void)setSelectModel:(ManageTypeModel *)selectModel
{
    _selectModel=selectModel;
    
    
    
}




-(void)getPlistData
{
    NSString *plistStr =[[NSBundle mainBundle]pathForResource:@"typeImage" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:plistStr];
    [_dataArray addObjectsFromArray:arr];
    
    
}


#pragma mark - Creat controls

-(void)createDeleteButton
{
    UIButton    *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = FRAME(20, _myCollectionV.bottomY+20.f, kScreenWidth-40.f, 40);
    deleteButton.backgroundColor = HexRGB(0xee4000);
    [deleteButton setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteManageType) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
}

-(void)createRightBtn
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = FRAME(kScreenWidth-60, 20+5, 50, 34);
    
    [rightButton setTitle:@"存储" forState:UIControlStateNormal];
    rightButton.backgroundColor= HexRGB(LINE_COLOR);
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.headView addSubview:rightButton];
    
    
    [rightButton addTarget:self action:@selector(saveToPlist) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)InitilizeTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:FRAME(20, NavaStatusHeight+30, kScreenWidth-40.f, 40)];
    topView.backgroundColor = HexRGB(SSSColor);
    topView.layer.borderWidth = 0.5f;
    topView.layer.borderColor = [HexRGB(LINE_COLOR)CGColor];
    [self.view addSubview:topView];
    
    
    
    _topImageView = [[UIImageView alloc]initWithFrame:FRAME(10, 0, 40, 40)];
    _topImageView.image = IMAGE_NAMED(_dataArray[currentSelect]);
    _topImageView.contentMode= UIViewContentModeCenter;
    [topView addSubview:_topImageView];
    
    _topTextField = [[UITextField alloc]initWithFrame:FRAME(60, 0, topView.width-60, 40)];
    _topTextField.placeholder = @"Name";
    [topView addSubview:_topTextField];
    
    
    if(_myCurrentType == Type_CA_Change)
    {
        _topTextField.text = self.selectModel.typeName;
        _topImageView.image = IMAGE_NAMED(self.selectModel.typeImage);
        
        for(int i=0;i<_dataArray.count;i++)
        {
            if([NSStringFormat(_dataArray[i]) isEqualToString:NSStringFormat(self.selectModel.typeImage)])
                
            {
                currentSelect = i;
            }
        }
        
        [_myCollectionV reloadData];
    }
    
    
    
}

-(void)InitilizeCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((kScreenWidth-40)/5, (kScreenWidth-40)/5);
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    
    _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(20, NavaStatusHeight+100, kScreenWidth-40, 200) collectionViewLayout:flowLayout];
    _myCollectionV.backgroundColor = HexRGB(SSSColor);
    _myCollectionV.layer.borderColor = [HexRGB(LINE_COLOR)CGColor];
    _myCollectionV.layer.borderWidth = 0.5f;
    _myCollectionV.delegate = self;
    _myCollectionV.dataSource =self;
    [self.view addSubview:_myCollectionV];
    
    [_myCollectionV registerClass:[ManageTypeAddCell class] forCellWithReuseIdentifier:ManageAddCellIdentify];

}
#pragma mark - Actions
-(void)saveToPlist
{
    
    NSString *plistStr =[[NSBundle mainBundle]pathForResource:@"typeImage" ofType:@"plist"];
    NSArray *imageTypearr = [NSArray arrayWithContentsOfFile:plistStr];
    
    NSString *colorStr =[[NSBundle mainBundle]pathForResource:@"StatisicalPlist" ofType:@"plist"];
    NSArray *colorarr = [NSArray arrayWithContentsOfFile:colorStr];
    NSString *myType;
    if(_isSpend)
    {
        myType = @"spend";
    }
    else
    {
        myType = @"income";
    }
    NSInteger temp;
    if(currentSelect>19)
    {
        temp=currentSelect-20;
    }
    else
    {
        temp = currentSelect;
    }
    
    
    if(_myCurrentType == Type_CA_Add)
    {
        NSMutableDictionary *myDict = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]mutableCopy];
        NSMutableArray *myArr = [[myDict objectForKey:myType]mutableCopy];
        ManageTypeModel *model = [[ManageTypeModel alloc]init];
        model.typeType = myType;
        NSString *tagstr =@"";
        tagstr= [NSString stringWithFormat:@"%@%@",[NSString returnCreateTime:[NSDate date]],_topTextField.text];
        NSDictionary *onedict = [NSDictionary dictionaryWithObjectsAndKeys:colorarr[temp],@"typeColor",imageTypearr[currentSelect],@"typeImage",_topTextField.text,@"typeName",tagstr,@"typeTag", nil];
        [myArr addObject:onedict];
        [myDict setObject:myArr forKey:myType];
        [myDict writeToFile:SpendAndIncome_TYPE_PATH atomically:YES];
    }
    else
    {
        NSMutableDictionary *myDict = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]mutableCopy];
        NSMutableArray *myArr = [[myDict objectForKey:myType]mutableCopy];
        for(int i=0;i<myArr.count;i++)
        {
            NSDictionary *onedict1 = myArr[i];
            NSString *str1 = [onedict1 objectForKey:@"typeTag"];
            if([str1 isEqualToString:self.selectModel.typeTag])
            {

                NSDictionary *onedict = [NSDictionary dictionaryWithObjectsAndKeys:colorarr[temp],@"typeColor",imageTypearr[currentSelect],@"typeImage",_topTextField.text,@"typeName",self.selectModel.typeTag,@"typeTag", nil];
                [myArr replaceObjectAtIndex:i withObject:onedict];
                
            }
        }
        [myDict setObject:myArr forKey:myType];
        [myDict writeToFile:SpendAndIncome_TYPE_PATH atomically:YES];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)deleteManageType
{
    NSString *myType;
    if(_isSpend)
    {
        myType = @"spend";
    }
    else
    {
        myType = @"income";
    }

    NSMutableDictionary *myDict = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]mutableCopy];
    NSMutableArray *myArr = [[myDict objectForKey:myType]mutableCopy];
    for(int i=0;i<myArr.count;i++)
    {
        NSDictionary *onedict1 = myArr[i];
        NSString *str1 = [onedict1 objectForKey:@"typeTag"];
        if([str1 isEqualToString:self.selectModel.typeTag])
        {
            
            [myArr removeObjectAtIndex:i];
            
        }
    }
    [myDict setObject:myArr forKey:myType];
    [myDict writeToFile:SpendAndIncome_TYPE_PATH atomically:YES];
    
    [self.navigationController popViewControllerAnimated:YES];

}



#pragma mark - UICollectViewDelegate

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
    return CGSizeMake((kScreenWidth-40)/5, (kScreenWidth-40)/5);
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ManageTypeAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ManageAddCellIdentify forIndexPath:indexPath];
    cell.imageNameStr = _dataArray[indexPath.item];

    if(currentSelect == indexPath.row)
    {
        [cell setImageBGchangeColor];
    }
    else
    {
        [cell resetColor];
    }
    
    
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //lastSelect = currentSelect;
    currentSelect = indexPath.row;
    [_myCollectionV reloadData];
    _topImageView.image = IMAGE_NAMED(_dataArray[currentSelect]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
