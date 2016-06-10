//
//  ViewController.m
//  webViewGoBack
//
//  Created by CrabMan on 16/6/6.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,strong) NSURL *url;



@end

@implementation ViewController
-(UIWebView *)webView {


    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        webView.delegate = self;
        
        //设置webView的背景颜色
        webView.scrollView.backgroundColor = [UIColor whiteColor];
       
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
        
        
        
        
        webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [webView loadRequest:[NSURLRequest requestWithURL:self.url]];
           
        }];
        
        _webView = webView;
        
        [self.view addSubview:_webView];
        
        
    }
    
    return _webView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
  UIBarButtonItem *goBackItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
  UIBarButtonItem *goForwardItem = [[UIBarButtonItem alloc]initWithTitle:@"前进" style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    
    goForwardItem.enabled = self.webView.canGoForward;
    self.navigationItem.leftBarButtonItems = @[goBackItem,goForwardItem];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    UIBarButtonItem *stopItem = [[UIBarButtonItem alloc]initWithTitle:@"停止" style:UIBarButtonItemStylePlain target:self action:@selector(stopLoading)];
    
    self.navigationItem.rightBarButtonItems = @[refreshItem,stopItem];
    
   
}

#pragma mark --- UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView {

    NSLog(@"开始请求");
    [self.webView.scrollView.mj_header beginRefreshing];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {

    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //起初将“前进”按钮的enable的属性设置到这里，但是用户体验度不好，改放到viewDidLoad里面
    [self.webView.scrollView.mj_header endRefreshing];


}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //页面是否被点击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        self.url = request.URL;
        return NO;
    }else{
        
        return YES;
    }
}
/**
 根据webView 的canGoBack属性来判断是否可以返回，如果可以返回则返回前一个页面，如果不可以则pop到上一个controller
 */
- (void)goBack {

    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

/**
同理设置webView的goForward属性
 */
- (void)goForward {


    if (self.webView.canGoForward) {
        [self.webView  goForward];
    }

}

- (void)reload {

    [self.webView reload];

}

- (void)stopLoading {

    [self.webView stopLoading];
    [self.webView.scrollView.mj_header endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
