//
//  iCokWebViewController.m
//  iCok
//
//  Created by Nelson on 2017/11/27.
//  Copyright © 2017年 Nelson. All rights reserved.
//

#import "iCokWebViewController.h"
#import <WebKit/WebKit.h>
@interface iCokWebViewController ()<WKNavigationDelegate>
@end

@implementation iCokWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webView.tag = 5050;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [self.navigationItem setLeftBarButtonItem:item];
}
-(void)dismiss{
    if ([self.url hasPrefix:@"https://openmobile.qq.com/oauth2.0/m_authorize?"]) {
        NSString * appid = [self.url componentsSeparatedByString:@"&client_id="].lastObject;
        NSString * url = [NSString stringWithFormat:@"tencent%@://qzapp/mqzone/0?generalpastboard=1",appid];
        NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
        [dictionary setValue:@"1" forKey:@"ret"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
        [[UIPasteboard generalPasteboard] setData:data forPasteboardType:[@"com.tencent.tencent" stringByAppendingString:appid]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        NSString * appid = [[self.url componentsSeparatedByString:@"appid="][1] componentsSeparatedByString:@"&"].firstObject;
        NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
        [dictionary setValue:@"Weixinauth" forKey:@"state"];
        [dictionary setValue:@"1" forKey:@"result"];
        NSDictionary * reqDictionary = [NSDictionary dictionaryWithObject:dictionary forKey:appid];
        NSData * data = [NSPropertyListSerialization dataWithPropertyList:reqDictionary format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
        [[UIPasteboard generalPasteboard] setData:data forPasteboardType:@"content"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://error?",appid]]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSString * requestURLString = webView.URL.absoluteString;
    if ([requestURLString hasPrefix:@"https://imgcache.qq.com/open/connect/widget/mobile/login/proxy.htm?"]) {
        NSString * openid = [[requestURLString componentsSeparatedByString:@"&openid="][1] componentsSeparatedByString:@"&"].firstObject;
        NSString * access_token = [[requestURLString componentsSeparatedByString:@"&access_token="][1] componentsSeparatedByString:@"&"].firstObject;
        NSString * appid = [[requestURLString componentsSeparatedByString:@"&appid="][1] componentsSeparatedByString:@"&"].firstObject;
        NSString * url = [NSString stringWithFormat:@"tencent%@://qzapp/mqzone/0?generalpastboard=1",appid];
        NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
        [dictionary setValue:openid forKey:@"openid"];
        [dictionary setValue:access_token forKey:@"access_token"];
        [dictionary setValue:@"0" forKey:@"ret"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
        [[UIPasteboard generalPasteboard] setData:data forPasteboardType:[@"com.tencent.tencent" stringByAppendingString:appid]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if ([webView.URL.absoluteString hasPrefix:@"wx"] && [webView.URL.absoluteString containsString:@"://oauth"]) {
        NSString * url = webView.URL.absoluteString;
        [self dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
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
