//
//  InstallHistoryViewController.m
//  TVForInstaller
//
//  Created by AlienLi on 15/5/22.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "InstallHistoryViewController.h"
#import "ComminUtility.h"
@interface InstallHistoryViewController ()

@end

@implementation InstallHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ComminUtility configureTitle:@"装机历史" forViewController:self];

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

@end
