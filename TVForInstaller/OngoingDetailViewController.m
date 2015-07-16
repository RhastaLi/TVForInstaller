//
//  OngoingDetailViewController.m
//  TVForInstaller
//
//  Created by AlienLi on 15/7/16.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "OngoingDetailViewController.h"

#import "ComminUtility.h"

@interface OngoingDetailViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *telphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *runningLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *wechatPay;
@property (weak, nonatomic) IBOutlet UIButton *alipay;

@property (nonatomic, assign) BOOL iswechatPay;
@end

@implementation OngoingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ComminUtility configureTitle:@"订单详情" forViewController:self];
    [self configOrderInfo];
    [self initialPayType];
    self.moneyTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard:(id)sender{
    [self.moneyTextField resignFirstResponder];
}

- (IBAction)clickPayType:(id)sender {
    UIButton *button = sender;
    
    if (button.tag == 0) {
        [self.wechatPay setImage:[UIImage imageNamed:@"ui03_WeChat-Payment_h"] forState:UIControlStateNormal];
        [self.alipay setImage:[UIImage imageNamed:@"ui03_-Alipay-Payment"] forState:UIControlStateNormal];
        _iswechatPay = YES;
    } else{
        [self.wechatPay setImage:[UIImage imageNamed:@"ui03_WeChat-Payment"] forState:UIControlStateNormal];
        [self.alipay setImage:[UIImage imageNamed:@"ui03_-Alipay-Payment_h"] forState:UIControlStateNormal];
        _iswechatPay = NO;

    }
}

-(void)configOrderInfo{
    //TODO: 客户资料
//    if (YES) {
//        self.typeImageView.image = [UIImage imageNamed:@"ui03_Broadband"];
//    } else{
//        self.typeImageView.image = [UIImage imageNamed:@"ui03_tv"];
//    }
    
    self.nameLabel.text = @"李敏表";
    self.addressLabel.text = @"成都市高新区新世界软件园D区5栋341是";
    self.telphoneLabel.text =@"13803932222";
    self.runningLabel.text = @"DAddddxxxxxx";
    self.dateLabel.text = @"2015-09-09 12:00";
    
}

-(void)initialPayType{
    [self.wechatPay setImage:[UIImage imageNamed:@"ui03_WeChat-Payment_h"] forState:UIControlStateNormal];
    [self.alipay setImage:[UIImage imageNamed:@"ui03_-Alipay-Payment"] forState:UIControlStateNormal];
    _iswechatPay = YES;

}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)createOrder:(id)sender {
}

@end
