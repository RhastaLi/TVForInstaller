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
#import "AccountManager.h"

#define kServer @"http://10.0.0.116:8080/zhiKey/appengController.do?enterService"


@implementation NetworkingManager


//+(void)Login;

+(void)focusNetWorkError{
    
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    
    hud.textLabel.text = @"网络出错啦";
    hud.indicatorView = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [hud showInView:delegate.window];
    [hud dismissAfterDelay:2.0];
    
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


+(void)registerCellphone:(NSString*)phone password:(NSString*)password inviteCode:(NSString*)inviteCode chinaID:(NSString*)chinaID verifyCode:(NSString*)verifyCode withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"phone":phone,@"password":password,@"invitecode":inviteCode,@"idcard":chinaID,@"code":verifyCode} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"10",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}



+(void)fetchVerifyCode:(NSString*)cellphoneNumber withComletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"phone":cellphoneNumber} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"11",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)ModifyPasswordwithNewPassword:(NSString*)password verifyCode:(NSString*)code withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"newpassword":password,@"id":[AccountManager getTokenID],@"code":code} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"32",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)forgetPasswordOnCellPhone:(NSString*)cellphone password:(NSString*)password verifyCode:(NSString*)code withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"phone":cellphone,@"newpassword":password,@"code":code} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"31",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchGradeByTokenID:(NSString*)tokenID withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"id":tokenID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"33",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}
+(void)fetchInviteByTokenID:(NSString*)tokenID withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"id":tokenID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"34",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchApplicationwithCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:@"http://10.0.0.116:8080/zhiKey/softController.do?getSoftService" parameters:nil success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchOrderwithCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
     NSString * param = [@{@"id":[AccountManager getTokenID]} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"41",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];

}

+(void)disableOrderByID:(NSString *)orderID withcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"orderid":orderID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"42",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)revokeOrderID:(NSString *)orderID ByTokenID:(NSString*)tokenID withcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"orderid":orderID,@"id":tokenID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"43",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)submitOrderDictionary:(NSDictionary*)order bill:(NSDictionary*)bill applist:(NSArray*)applist source:(NSString*)source withcompletionHandler:(NetWorkHandler)completionHandler failHandle:(NetWorkFailHandler)failHandler{

    
    NSString * param = [@{@"order":order,@"bill":bill,@"source":source,@"applist":applist} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"44",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
    
}



@end
