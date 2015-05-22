//
//  NetworkingManager.m
//  TVForInstaller
//
//  Created by AlienLi on 15/5/7.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "NetworkingManager.h"
#import "NSDictionary+JSONString.h"
#import <JGProgressHUD.h>
#import "AppDelegate.h"


#define kServer @"http://192.168.0.166:8080/tvgeek/appEngController.do?enterService"


@implementation NetworkingManager


//+(void)Login;

+(void)focusNetWorkError{
    
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    
    hud.textLabel.text = @"网络出错啦";
    hud.indicatorView = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [hud showInView:delegate.window];
    [hud dismissAfterDelay:1.0];
    
}

+(void)login:(NSString*)account withPassword:(NSString *)password withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"phone":account,@"password":password} bv_jsonStringWithPrettyPrint:YES];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"20",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}




+(void)uploadPeronsalInfoName:(NSString*)name cellPhone:(NSString*)phoneNumber chinaID:(NSString*)chinaID withCompletionHandler:(NetWorkHandler)completionHandler{
    
}

@end
