//
//  CustomeWebView.h
//  SimpleInteraction(OC)
//
//  Created by CrabMan on 16/6/4.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol CustomeWebViewDelegate <JSExport>

/**
 OC方法供JS调用
 */
- (void)showAlertViewControllerWithoutParam ;

/**
 JS调用OC无参数方法，然后OC方法调用JS无参的方法
 使用场景距离：H5界面上面有牌照按钮，然后调用oc相机牌照，拍完照片以后跳入H5另一个界面
 */
- (void)JSCallObjcMethodAndObjcCallJSMethodWithoutParam;
/**
 JS调用OC有参数参数方法，然后OC方法调用JS有参数的方法
 */
- (void)JSCallObjcMethodAndObjcCallJSMethodWithDictionary:(NSDictionary *)dic;

@end

@interface CustomeWebView : UIWebView <CustomeWebViewDelegate>

@property (nonatomic,weak) JSContext *context;

@end
