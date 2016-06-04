//
//  ViewController.m
//  SimpleInteraction(OC)
//
//  Created by CrabMan on 16/6/4.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "Category.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,weak) JSContext *context;

@end

@implementation ViewController

-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/2)];
        _webView.backgroundColor = [UIColor lightGrayColor];
    
        _webView.delegate = self;
    }
    return _webView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Test.html" withExtension:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:self.webView];
    
    
    
    
    
    
    //第一个button用于OC调用JS
    UIButton * firstButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, 100, 40)];
    firstButton.backgroundColor = [UIColor redColor];
    
    [firstButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
         [_webView stringByEvaluatingJavaScriptFromString:@"aaa()"];
    }];
    
    [self.view addSubview:firstButton];
    
    
   //第二个button用于OC调用JS
    UIButton * secondButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 550, 100, 40)];
    secondButton.backgroundColor = [UIColor greenColor];
    
    [secondButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
         [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"bbb('%@')",@"OC调用JS有参数方法，这段字符串就作为参数传递"]];
    }];
    
    [self.view addSubview:secondButton];
}



#pragma mark --- UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView {

    NSLog(@"网页开始加载");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"网页加载完毕");
    
   
    
    
    
    
    //获取js的运行环境，字符串内容为固定写发
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //OC调用JS方法
   
    
    
    //也直接调用JS代码（不推荐）
    NSString *alertJS = @"alert('请注意，前方高能...')";
    [_context evaluateScript:alertJS];


    /*
     1.调用时机为加载完成以后：截取方法名,替换为block内部方法. ---- 替换方法
     contex[contextType] = ^{};
     2.我加载的html内部有方法名为test1和test2,通过context来将方法直接赋值成一个block,来替换掉原来的function copyText方法,从而调用js代码中的copyText的时候就调用block内部的oc代码.
     */
    
    //html调用无参数OC
    _context[@"test1"] = ^(){
        [self showFirstAletVieController];
    };
    
    //html调用OC(传参数过来)
   _context[@"test2"] = ^(){
        NSArray * args = [JSContext currentArguments];//传过来的参数
               for (id  obj in args) {
                    NSLog(@"html传过来的参数%@",obj);
                }
       
    
        [self showSecondAletVieController:args[0] andTimes:args[1]];
   };

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网页加载错误");

}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//
//
//}

#pragma mark ---native method（供JS调用）

- (void)showFirstAletVieController {

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知" message:@"JS调用OC方法" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    
    
    
    //不适用CDG会报错：This application is modifying the autolayout engine from a background thread, which can lead to engine corruption and weird crashes.  This will cause an exception in a future release.解决方案回到主线程更新UI

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:alertVC animated:YES completion:nil];
    });
    
    
    

}

- (void)showSecondAletVieController:(NSString *)user andTimes:(NSString *)times {

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知" message:[NSString stringWithFormat:@"%@通过JS调用了OC方法%@次",user,times] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    
    
    //同样用于解决崩溃隐患
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertVC animated:YES completion:nil];
    });
    
    ;

}
@end
