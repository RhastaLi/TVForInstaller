//
//  OrderDetailViewController.m
//  TVForInstaller
//
//  Created by AlienLi on 15/7/16.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "ComminUtility.h"
#import "BNCoreServices.h"
#import "AccountManager.h"
#import "OngoingOrder.h"
#import "NetworkingManager.h"
#import <SVProgressHUD.h>

@interface OrderDetailViewController ()<BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ComminUtility configureTitle:@"订单详情" forViewController:self];
    
    [self configOrderContent];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    [BNCoreServices_Instance startServicesAsyn:^{
        NSLog(@"success");
    } fail:^{
        NSLog(@"fail");
    }];
    
   
}

-(void)pop{
    
    [NetworkingManager ModifyOrderStateByID:self.info[@"uid"] latitude:[self.info[@"location"][1] doubleValue] longitude:[self.info[@"location"][0] doubleValue] order_state:@"0" WithcompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)call:(id)sender {
    
     UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"" message:self.info[@"phone"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.info[@"phone"]]]];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

}
- (IBAction)confirmOrder:(id)sender {
//    [self startNavi];
    
    //确认订单，修改状态
    [SVProgressHUD showWithStatus:@"接单中"];
    
    [NetworkingManager ModifyOrderStateByID:self.info[@"uid"] latitude:[self.info[@"location"][1] doubleValue] longitude:[self.info[@"location"][0] doubleValue] order_state:@"2" WithcompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];

        if ([responseObject[@"status"] integerValue] == 0) {
            [self setOrderStateAndNoteToNavi];
        }

    } failHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];

}

-(void)setOrderStateAndNoteToNavi{
    
    [OngoingOrder setExistOngoingOrder:YES];
    [OngoingOrder setOrder:self.info];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"是否开始导航？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        if ([_delegate respondsToSelector:@selector(didConfirmOrderFrom:to:)]) {
            [self.navigationController popViewControllerAnimated:YES];
            [_delegate didConfirmOrderFrom:_originalPostion to:_destinationPosition];
        }
    }];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alert addAction:action];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)configOrderContent{
    
    if ([self.info[@"order_type"] integerValue] == 0) {
        self.typeImageView.image = [UIImage imageNamed:@"ui03_tv"];
    } else{
        self.typeImageView.image = [UIImage imageNamed:@"ui03_Broadband"];
    }
    self.nameLabel.text = self.info[@"name"];
    self.telphoneLabel.text = self.info[@"phone"];
    self.addressLabel.text = self.info[@"home_address"];
    self.dateLabel.text = self.info[@"order_time"];
}





@end
