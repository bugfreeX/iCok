//
//  ViewController.m
//  iCok
//
//  Created by Nelson on 2017/11/27.
//  Copyright © 2017年 Nelson. All rights reserved.
//

#import "ViewController.h"
#import "iCok.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BOOL isWeChatInstalled = [iCok isWeChatInstalled];
    BOOL isQQInstalled = [iCok isQQInstalled];
    NSLog(@"微信安装状态:%d    QQ安装状态:%d",isWeChatInstalled,isQQInstalled);
}

- (IBAction)segmentAction:(id)sender {
    NSInteger index = ((UISegmentedControl *)sender).selectedSegmentIndex;
    ((UISegmentedControl *)sender).selectedSegmentIndex = -1;
    switch (index) {
        case 0:{
            [iCok loginWithWXAppId:@"wxa6711111111" appSecret:@"bb870c004ac64486379341949e17d5b4" completeHandler:^(NSDictionary *response) {
                NSLog(@"微信登录成功:%@",response);
            } failure:^(NSError *error) {
                NSLog(@"微信登录失败:%@",error);
            }];
        }break;
        case 1:{
            [iCok payWithWXAppId:@"wxa6711111111" partnerId:@"1481780342" prepayId:@"wx2911544713016644f156aae92694821682" nonceStr:@"XjiVmUyU48Mgqb664cZxbv52ujhVgdyR" timeStamp:@"1535514887" package:@"Sign=WXPay" sign:@"FBF9D9783DD2661D574C51E0E15B0C0F" completedHandler:^(NSInteger errorCode, NSString *msg) {
                NSLog(@"微信支付");
                NSLog(@"errorCode : %ld",errorCode);
                NSLog(@"msg : %@",msg);
            }];
            
        }break;
        case 2:{
            [iCok shareWithWXAppId:@"wxa67eeeb312ddcbf3" scene:ICOK_SESSION_TYPE title:@"title" description:@"description" link:@"https://www.github.com" image:[UIImage imageNamed:@"profile"] completeHandler:^(NSDictionary *response) {
                NSLog(@"微信分享成功");
            } failure:^(NSError *error) {
                NSLog(@"微信分享失败:%@",error);
            }];
            
        }break;
        case 3:{
            [iCok loginWithQQAppId:@"111111111" completeHandler:^(NSDictionary *response) {
                NSLog(@"QQ登录成功:%@",response);
            } failure:^(NSError *error) {
                NSLog(@"QQ登录失败:%@",error.description);
            }];
        }break;
        case 4:{
            [iCok shareWithQQAppId:@"111111111" scene:ICOK_SESSION_TYPE title:@"title" description:@"description" link:@"https://www.github.com" image:[UIImage imageNamed:@"profile"] completeHandler:^(NSDictionary *response) {
                NSLog(@"QQ分享成功");
            } failure:^(NSError *error) {
                NSLog(@"QQ分享失败:%@",error.description);
            }];
            
        }break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
