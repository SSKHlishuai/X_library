//
//  IncomeTable.m
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "IncomeTable.h"
#import "ManageTypeModel.h"

#define CellHeight  50.f


@implementation IncomeTable


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self= [super initWithFrame:frame style:style];
    if(self)
    {
        self.delegate=self;
        self.dataSource=self;
        _dataArray = [[NSMutableArray alloc]init];
        
        [self getLocalData];
        
    }
    return self;
}

-(void)getLocalData
{
    [_dataArray removeAllObjects];
    NSArray *myArr = [[NSDictionary dictionaryWithContentsOfFile:SpendAndIncome_TYPE_PATH]objectForKey:@"income"];
    
    for(NSDictionary *dict in myArr)
    {
        ManageTypeModel *model = [[ManageTypeModel alloc]initWithDict:dict withType:@"income"];
        [_dataArray addObject:model];
    }
    
    [self reloadData];
    
    
}

#pragma mark -------tablvewdelegate--------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCellId];
        cell.contentView.backgroundColor = HexRGB(SSSColor);
        UIView *lineview = [[UIView alloc]initWithFrame:FRAME(0, CellHeight-0.5, kScreenWidth, 0.5)];
        lineview.backgroundColor=HexRGB(LINE_COLOR);
        [cell.contentView addSubview:lineview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ManageTypeModel *model = _dataArray[indexPath.row];
    
    cell.imageView.image = IMAGE_NAMED(model.typeImage);
    
    cell.detailTextLabel.text = model.typeName;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ManageTypeModel *model = _dataArray[indexPath.row];
    
    if([self.MTAdelegate respondsToSelector:@selector(pushManageAddType:)])
    {
        [self.MTAdelegate performSelector:@selector(pushManageAddType:)withObject:model];
    }

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
