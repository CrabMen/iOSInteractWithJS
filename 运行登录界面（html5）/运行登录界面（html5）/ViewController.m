//
//  ViewController.m
//  运行登录界面（html5）
//
//  Created by CrabMan on 16/6/11.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation ViewController
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL fileURLWithPath:@"/Users/CrabMan/Documents/iOSInteractWithJS/运行登录界面（html5）/运行登录界面（html5）/登录界面/index.html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:self.webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
