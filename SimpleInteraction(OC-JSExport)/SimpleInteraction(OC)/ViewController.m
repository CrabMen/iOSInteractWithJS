//
//  ViewController.m
//  SimpleInteraction(OC)
//
//  Created by CrabMan on 16/6/4.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "CustomeWebView.h"
#import "Category.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) CustomeWebView *webView;
@property (nonatomic,strong) JSContext *context;


@end

@implementation ViewController

-(CustomeWebView *)webView {
    if (!_webView) {
        
       _webView = [[CustomeWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
        _webView.scalesPageToFit = YES
        ;
        _webView.delegate = self;
       
      NSURL *url = [[NSBundle mainBundle] URLForResource:@"Test.html" withExtension:nil];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        _webView.backgroundColor = [UIColor redColor];
    
        
    }
    return _webView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     知识点讲解:
    JSContext, JSContext是代表JS的执行环境，通过-evaluateScript:方法就可以执行一JS代码；同样也可以使用webView直接调用JS代码
    JSValue, JSValue封装了JS与ObjC中的对应的类型，以及调用JS的API等
    JSExport, JSExport是一个协议，遵守此协议，就可以定义我们自己的协议，在协议中声明的API都会在JS中暴露出来，才能调用*/
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    

}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //通过直接调用JS代码
     [self.webView stringByEvaluatingJavaScriptFromString:@"alert('请注意，前方高能...')"];
    
   
    
     self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //第二种直接调用JS代码的方法，但是必须初始化context
    [_context evaluateScript:@"alert('第二种直接调用JS的方法')"];
    NSLog(@"加载完毕");
    
    
    CustomeWebView *webViewModel =  [[CustomeWebView alloc]init];
   
    
    self.context[@"webView"] = webViewModel;
    
    webViewModel.context = self.context;
 
   
   
    
    //如果没有注入模型，需要抛异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
}








@end
