//
//  mainViewController.m
//  webViewGoBack
//
//  Created by CrabMan on 16/6/6.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "mainViewController.h"
#import "ViewController.h"
@implementation mainViewController
-(void)viewDidLoad {

    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 40)];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpToNextViewController:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];

}

- (void)jumpToNextViewController:(id)sender {

    [self.navigationController pushViewController:[ViewController new] animated:YES];

}
@end
