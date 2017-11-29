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
            [iCok loginWithWXAppId:@"wxa67eeeb312ddcbf3" completeHandler:^(NSDictionary *response) {
                NSLog(@"微信登录成功:%@",response);
            } failure:^(NSError *error) {
                NSLog(@"微信登录失败:%@",error);
            }];
        }break;
        case 1:{
            [iCok shareWithWXAppId:@"wxa67eeeb312ddcbf3" scene:ICOK_SESSION_TYPE title:@"title" description:@"description" link:@"https://www.github.com" image:[UIImage imageNamed:@"profile"] completeHandler:^(NSDictionary *response) {
                NSLog(@"微信分享成功");
            } failure:^(NSError *error) {
                NSLog(@"微信分享失败:%@",error);
            }];
            
        }break;
        case 2:{
            [iCok loginWithQQAppId:@"1105209207" completeHandler:^(NSDictionary *response) {
                NSLog(@"QQ登录成功:%@",response);
            } failure:^(NSError *error) {
                NSLog(@"QQ登录失败:%@",error.description);
            }];
        }break;
        case 3:{
            [iCok shareWithQQAppId:@"1105209207" scene:ICOK_SESSION_TYPE title:@"title" description:@"description" link:@"https://www.github.com" image:[UIImage imageNamed:@"profile"] completeHandler:^(NSDictionary *response) {
                NSLog(@"QQ分享成功");
            } failure:^(NSError *error) {
                NSLog(@"QQ分享失败:%@",error);
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
