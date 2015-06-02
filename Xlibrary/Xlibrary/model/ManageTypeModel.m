//
//  ManageTypeModel.m
//  Xlibrary
//
//  Created by mc on 15/4/27.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "ManageTypeModel.h"

@implementation ManageTypeModel


-(instancetype)initWithDict:(NSDictionary*)dic withType:(NSString *)typeStr
{
    self= [super init];
    if(self)
    {
        self.typeType = NSStringFormat(typeStr);
        self.typeTag = NSStringFormat([dic objectForKey:@"typeTag"]);
        self.typeColor = NSStringFormat([dic objectForKey:@"typeColor"]);
        self.typeImage = NSStringFormat([dic objectForKey:@"typeImage"]);
        self.typeName = NSStringFormat([dic objectForKey:@"typeName"]);
        
    }
    return self;
}

@end
