//
//  AppDelegate.m
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "AppDelegate.h"
#import "leftViewController.h"
#import "centerViewController.h"
#import "XPIModel.h"
#import "XDatabase.h"
#import "GesturePwdViewController.h"

@interface AppDelegate ()<GPwdVerifyDelegate>
{
    GesturePwdViewController *_pwdVC;
    centerViewController *zoomNavigationController;
}
@end

@implementation AppDelegate




#pragma mark --------链接数据库
-(void)MNcopyDataBase
{
    XLog(@"%@",MNDB_PATH);
    if(![[NSFileManager defaultManager]fileExistsAtPath:MNDB_PATH]){
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"GB" ofType:@"db"] toPath:MNDB_PATH error:nil];
        
    }
}



-(void)InitlizePlist
{
    /**
     NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  www.2cto.com
     NSString *path=[paths    objectAtIndex:0];
     NSLog(@"path = %@",path);
     NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];
     NSFileManager* fm = [NSFileManager defaultManager];
     [fm createFileAtPath:filename contents:nil attributes:nil];
     //NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
     
     //创建一个dic，写到plist文件里
     NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"sina",@"1",@"163",@"2",nil];
     [dic writeToFile:filename atomically:YES];
     
     //读文件
     NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
     NSLog(@"dic is:%@",dic2);
     */
    if(![[NSFileManager defaultManager]fileExistsAtPath:ACCOUNT_TYPE_PATH])
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *filename = [path stringByAppendingPathComponent:@"AccountType.plist"];
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"gesture",@"0",@"isGestureOn",@"0",@"isBudgetOn",@"1",@"budget",@"off",@"isCanDelete", nil] forKey:@"现金"];
        [dic writeToFile:filename atomically:YES];
        
    }
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:SpendAndIncome_TYPE_PATH])
    {
        
        NSString *plistStr =[[NSBundle mainBundle]pathForResource:@"typeImage" ofType:@"plist"];
        NSArray *imageTypearr = [NSArray arrayWithContentsOfFile:plistStr];
        
        NSString *colorStr =[[NSBundle mainBundle]pathForResource:@"StatisicalPlist" ofType:@"plist"];
        NSArray *colorarr = [NSArray arrayWithContentsOfFile:colorStr];
        
        NSString *chineseStr =[[NSBundle mainBundle]pathForResource:@"StatisicalChinesePlist" ofType:@"plist"];
        NSArray *chinesearr = [NSArray arrayWithContentsOfFile:chineseStr];


        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *filename = [path stringByAppendingPathComponent:@"SpendAndIncomeType.plist"];
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        NSMutableDictionary *myDict = [[NSMutableDictionary alloc]init];;
        
        NSMutableArray *defaultspendArr = [NSMutableArray array];
        for(int i=0;i<20;i++)
        {
            NSString *tagstr =@"";
            tagstr= [NSString stringWithFormat:@"%@%@",[NSString returnCreateTime:[NSDate date]],chinesearr[i]];
            NSDictionary *onedict = [NSDictionary dictionaryWithObjectsAndKeys:colorarr[i],@"typeColor",imageTypearr[i],@"typeImage",chinesearr[i],@"typeName",tagstr,@"typeTag", nil];
            
            [defaultspendArr addObject:onedict];
        }
        

        [myDict setObject:defaultspendArr forKey:@"spend"];
        NSMutableArray *defaultincomeArr = [NSMutableArray array];
        
        
        int a[] = {20,21,22,16,19};
        for(int i=0;i<5;i++)
        {
            int temp;
            if(a[i]>19)
            {
                temp = a[i]-20;
            }
            NSString *tagstr =@"";
            tagstr= [NSString stringWithFormat:@"%@%@",[NSString returnCreateTime:[NSDate date]],chinesearr[20+i]];
            NSDictionary *onedict = [NSDictionary dictionaryWithObjectsAndKeys:colorarr[temp],@"typeColor",imageTypearr[a[i]],@"typeImage",chinesearr[20+i],@"typeName",tagstr,@"typeTag", nil];
            
            [defaultincomeArr addObject:onedict];
        }
        

        [myDict setObject:defaultincomeArr forKey:@"income"];
        [myDict writeToFile:filename atomically:YES];
        
    }

   
    
    
}

-(void)setDefault
{
    
    
    NSUSERDEFAULTS(myDefault);
    
    if(![myDefault objectForKey:IS_ON_PWD])
    {
        [myDefault setObject:@"NO" forKey:IS_ON_PWD];
        [myDefault synchronize];
    }

    
    [AppUserInfor getInstanceUser].isOnPwd = [myDefault objectForKey:IS_ON_PWD];
    NSLog(@"%@",[AppUserInfor getInstanceUser].isOnPwd);
    if([myDefault objectForKey:PWD_STR])
    {
        [AppUserInfor getInstanceUser].pwdStr = [myDefault objectForKey:PWD_STR];
    }
    else
    {
        [AppUserInfor getInstanceUser].pwdStr = @"-1";
    }
    
    
    if(![myDefault objectForKey:BudgetCount])
    {
        [myDefault setObject:@"10000" forKey:BudgetCount];
        [myDefault setObject:@"YES" forKey:BudgetOn];
        [myDefault setObject:@"1" forKey:BudgetFrom];
    
        [myDefault synchronize];
        
        
    
    
    }
    [AppUserInfor getInstanceUser].budgetCount = [myDefault objectForKey:BudgetCount];
    [AppUserInfor getInstanceUser].budgetFrom = [myDefault objectForKey:BudgetFrom];
    [AppUserInfor getInstanceUser].budgetOn = [myDefault objectForKey:BudgetOn];

    

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    NSLog(@"%@",NSHomeDirectory());
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self MNcopyDataBase];
    [self InitlizePlist];
    [self setDefault];
    leftViewController *left = [leftViewController new];
    zoomNavigationController = [centerViewController new];
    [zoomNavigationController setSpringAnimationOn:YES];
    [zoomNavigationController setLeftViewController:left];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [zoomNavigationController setBackgroundView:imageView];
    
    [[self window] setRootViewController:zoomNavigationController];
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if([[AppUserInfor getInstanceUser].isOnPwd isEqualToString:@"YES"])
    {
        if(!_pwdVC)
        {
            _pwdVC = [[GesturePwdViewController alloc]initWithType:TYPE_VerifyOrReset_verify];
            _pwdVC.gestDelegate = self;
        }
        
        self.window.rootViewController = _pwdVC;
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

-(void)changeRootViewController
{
    self.window.rootViewController = zoomNavigationController;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
