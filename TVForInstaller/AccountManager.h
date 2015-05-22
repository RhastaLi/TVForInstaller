//
//  AccountManager.h
//  TVForInstaller
//
//  Created by AlienLi on 15/5/19.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

+(BOOL)isLogin;
+(void)setLogin:(BOOL)login;



+(NSString*)getPassword;
+(void)setPassword:(NSString*)password;

+(NSString*)getCellphoneNumber;
+(void)setCellphoneNumber:(NSString*)cellphone;

+(NSString*)getIDCard;
+(void)setIDCard:(NSString*)IDcard;

+(NSString*)getName;
+(void)setName:(NSString*)name;

+(NSString*)getAvatarUrlString;
+(void)setAvatarUrlString:(NSString*)url;




+(NSString*)getLeaderID;
+(void)setLeaderID:(NSString*)leaderID;





@end
