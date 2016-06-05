//
//  CustomeWebView.m
//  SimpleInteraction(OC)
//
//  Created by CrabMan on 16/6/4.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "CustomeWebView.h"
#import "Category/Category.h"

@interface CustomeWebView ()



@end

@implementation CustomeWebView

/**
 OC方法供JS调用
 */
- (void)showAlertViewControllerWithoutParam {

    NSLog(@"showAlertViewControllerWithoutParam方法被调用");
    
    
    /*使用下面方法报错：Attempting to load the view of a view controller while it is deallocating is not allowed and may result in undefined behavior
     查了一些资料，暂未解决该问题，通过breakpoint发现，self应该被释放了
     目前主要任务是实现JS与OC交互，先使用过期方法UIAlertView实现功能
     */
    
    
    
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知" message:@"JS调用OC无参数方法" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//    [alertVC addAction:cancelAction];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        [self.navigationController pushViewController:alertVC animated:YES];
//        
//    });
//    

    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""  message:@"JS调用无参数的OC方法" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    
    //使用GCD回归主线程避免报错
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView show];
    });
    
    
    

}

/**
 JS调用OC无参数方法，然后OC方法调用JS无参的方法
 使用场景距离：H5界面上面有牌照按钮，然后调用oc相机牌照，拍完照片以后跳入H5另一个界面
 */
- (void)JSCallObjcMethodAndObjcCallJSMethodWithoutParam{

    NSLog(@"JS调用系统相机");
    /*然后调用JS方法获得h5方法名
    第一次有bug无法调用js的方法，原因是ViewController里面的context属性使用weak无法传值过来为空
     */
 JSValue *JSFunc = self.context[@"jsFunc"];
    //js执行对应的方法
    [JSFunc callWithArguments:nil];

}
/**
 JS调用OC有参数参数方法，然后OC方法调用JS有参数的方法，调用方法一样，只不过需要注意参数的传递方式
 */
- (void)JSCallObjcMethodAndObjcCallJSMethodWithDictionary:(NSDictionary *)dic {

    NSLog(@"JS调用有参数OC方法，参数为:%@",dic);
    
    //在这里可以对参数进行处理，并将处理后的数据传给JS
    JSValue *jsValue = self.context[@"jsParamFunc"];
    
    [jsValue callWithArguments:@[@{@"age": @90, @"name": @"CrabMan", @"height": @168}]];


}






@end
