//
//  OrderDetailViewController.h
//  TVForInstaller
//
//  Created by AlienLi on 15/7/16.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNCoreServices.h"


@protocol DidConfirmOrderDelegate <NSObject>

-(void)didConfirmOrderFrom:(BNPosition *)originalAddress to:(BNPosition*)destinationAddress;

@end

typedef enum ServiceType: NSUInteger {
    TV,
    BROADBAND,
    SERVICE
    
} ServiceType;


@interface OrderDetailViewController : UIViewController

//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *address;
//
//@property (nonatomic, copy) NSString *telphone;
//@property (nonatomic, copy) NSString *runningNumber;
//@property (nonatomic, copy) NSString *date;
//@property (nonatomic, assign) ServiceType type;

@property (nonatomic, strong) BNPosition *originalPostion;
@property (nonatomic, strong) BNPosition *destinationPosition;

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic,weak) id<DidConfirmOrderDelegate> delegate;

@end
