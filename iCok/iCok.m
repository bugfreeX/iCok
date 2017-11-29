//
//  iCok.m
//  iCok
//
//  Created by Nelson on 2017/11/27.
//  Copyright © 2017年 Nelson. All rights reserved.
//

#import "iCok.h"
#import <UIKit/UIKit.h>
#import "iCokWebViewController.h"
#import <WebKit/WebKit.h>
static iCokCompleteHandler _completeHandler;
static iCokFailure _failure;
@implementation iCok
+(void)loginWithWXAppId:(NSString *)appid completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure{
    if (handler) {
        _completeHandler = handler;
    }
    if (failure) {
        _failure = failure;
    }
    NSString * urlString = [NSString stringWithFormat:@"weixin://app/%@/auth/?scope=snsapi_userinfo&state=Weixinauth",appid];
    BOOL open = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    if (!open) {
        NSString * url = [NSString stringWithFormat:@"https://open.weixin.qq.com/connect/mobilecheck?appid=%@&uid=1",appid];
        iCokWebViewController * viewController = [[iCokWebViewController alloc]init];
        viewController.url = url;
        viewController.title = @"微信登录";
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    }
}

+(void)shareWithWXAppId:(NSString *)appid scene:(iCokSceneType)scene title:(NSString *)title description:(NSString *)description link:(NSString *)link image:(UIImage *)image completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure{
    if (handler) {
        _completeHandler = handler;
    }
    if (failure) {
        _failure = failure;
    }
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:@"1" forKey:@"result"];
    [dictionary setValue:@"0" forKey:@"returnFromApp"];
    [dictionary setValue:@(scene) forKey:@"scene"];
    [dictionary setValue:@"1.5" forKey:@"sdkver"];
    [dictionary setValue:@"1010" forKey:@"command"];
    [dictionary setValue:title forKey:@"title"];
    [dictionary setValue:description forKey:@"description"];
    [dictionary setValue:link forKey:@"mediaUrl"];
    [dictionary setValue:[self dataWithImage:image size:CGSizeMake(100, 100)] forKey:@"thumbData"];
    [dictionary setValue:@"5" forKey:@"objectType"];
    NSData *output = [NSPropertyListSerialization dataWithPropertyList:@{appid:dictionary} format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
    [[UIPasteboard generalPasteboard] setData:output forPasteboardType:@"content"];
    NSString * urlString = [NSString stringWithFormat:@"weixin://app/%@/sendreq/?",appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+ (NSData *)dataWithImage:(UIImage *)image size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(scaledImage, 1);
}

+(void)loginWithQQAppId:(NSString *)appid completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure{
    if (handler) {
        _completeHandler = handler;
    }
    if (failure) {
        _failure = failure;
    }
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:appid forKey:@"app_id"];
    [dictionary setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleName"] forKey:@"app_name"];
    [dictionary setValue:appid forKey:@"client_id"];
    [dictionary setValue:@"token" forKey:@"response_type"];
    [dictionary setValue:@"get_user_info" forKey:@"scope"];
    [dictionary setValue:@"i" forKey:@"sdkp"];
    [dictionary setValue:@"2.9" forKey:@"sdkv"];
    [dictionary setValue:[UIDevice currentDevice].model forKey:@"status_machine"];
    [dictionary setValue:[UIDevice currentDevice].systemVersion forKey:@"status_os"];
    [dictionary setValue:[UIDevice currentDevice].systemVersion forKey:@"status_version"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    [[UIPasteboard generalPasteboard] setData:data forPasteboardType:[@"com.tencent.tencent" stringByAppendingString:appid]];
    BOOL open = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqqOpensdkSSoLogin://SSoLogin/tencent%@/com.tencent.tencent%@?generalpastboard=1",appid,appid]]];
    if (!open) {
        NSString * url = [NSString stringWithFormat:@"https://openmobile.qq.com/oauth2.0/m_authorize?state=test&sdkp=i&response_type=token&display=mobile&scope=get_user_info,get_simple_userinfo,add_album,add_one_blog,add_share,add_topic,check_page_fans,get_info,get_other_info,list_album,upload_pic,get_vip_info,get_vip_rich_info&status_version=%@&sdkv=3.1_lite&status_machine=%@&status_os=%@&switch=1&redirect_uri=auth://www.qq.com&client_id=%@",[UIDevice currentDevice].systemVersion,[UIDevice currentDevice].model,[UIDevice currentDevice].systemVersion,appid];
        iCokWebViewController * viewController = [[iCokWebViewController alloc]init];
        viewController.url = url;
        viewController.title = @"QQ登录";
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    }
}

+(void)shareWithQQAppId:(NSString *)appid scene:(iCokSceneType)scene title:(NSString *)title description:(NSString *)description link:(NSString *)link image:(id)image completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure{
    if (handler) {
        _completeHandler = handler;
    }
    if (failure) {
        _failure = failure;
    }
    NSData * data = UIImageJPEGRepresentation(image, 1);
    NSDictionary * dictionary = @{@"previewimagedata":data};
    NSData * archiverData = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    [[UIPasteboard generalPasteboard] setData:archiverData forPasteboardType:@"com.tencent.mqq.api.apiLargeData"];
    NSString * callback_name = [NSString stringWithFormat:@"QQ%08llx",[appid longLongValue]];
    NSString * displayName = [[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSString * _title = [[[title dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString * _description = [[[description dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString * _link = [[[link dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString * url = [NSString stringWithFormat:@"mqqapi://share/to_fri?thirdAppDisplayName=%@&version=1&cflag=%@&callback_type=scheme&generalpastboard=1&callback_name=%@&src_type=app&shareType=0&file_type=news&title=%@&url=%@&description=%@&objectlocation=pasteboard",displayName,[NSString stringWithFormat:@"%ld",scene],callback_name,_title,_link,_description
                      ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+(BOOL)isWeChatInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
}

+(BOOL)isQQInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}

+(BOOL)openURL:(NSURL *)url{
    NSLog(@"openURL:%@",url.absoluteString);
    if ([url.absoluteString containsString:@"tencent"]) {
        if ([url.absoluteString containsString:@"response_from_qq?"]) {
            NSDictionary * response = [self parseUrl:url];
            if ([response[@"error"] intValue] != 0 && response[@"error_description"]) {
                if (_failure) {
                    NSString * errorMsg = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:response[@"error_description"] options:0] encoding:NSUTF8StringEncoding];
                    NSInteger errorCode = [response[@"error"] integerValue];
                    _failure([NSError errorWithDomain:@"qq_share" code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMsg}]);
                }
            }else{
                if (_completeHandler) {
                    _completeHandler(response);
                }
            }
        }else{
            NSString * appid = [[url.absoluteString componentsSeparatedByString:@"://"].firstObject componentsSeparatedByString:@"tencent"].lastObject;
            NSData * data = [[UIPasteboard generalPasteboard] dataForPasteboardType:[@"com.tencent.tencent" stringByAppendingString:appid]];
            NSDictionary * response = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (response[@"ret"]&&[response[@"ret"] intValue] == 0) {
                if (_completeHandler) {
                    _completeHandler(response);
                }
            }else{
                if (_failure) {
                    if ([response.allKeys containsObject:@"msg"]) {
                        _failure([NSError errorWithDomain:@"qq_auth" code:0 userInfo:@{NSLocalizedDescriptionKey:response[@"msg"]}]);
                    }else{
                        _failure([NSError errorWithDomain:@"qq_auth" code:0 userInfo:@{NSLocalizedDescriptionKey:@"the user give up the current operation"}]);
                    }
                }
            }
        }
    }else if([url.absoluteString hasPrefix:@"wx"]){
        NSString * appid = [url.absoluteString componentsSeparatedByString:@"://"].firstObject;
        NSDictionary * dictionary = [NSPropertyListSerialization propertyListWithData:[[UIPasteboard generalPasteboard] dataForPasteboardType:@"content"]?:[[NSData alloc]init] options:0 format:0 error:nil][appid];
        if ([url.absoluteString containsString:@"://oauth"]) {
            if (_completeHandler) {
                _completeHandler([self parseUrl:url]);
            }
        }else if ([url.absoluteString containsString:@"://wapoauth"]){
            NSDictionary * response = [self parseUrl:url];
            NSString * url = [NSString stringWithFormat:@"https://open.weixin.qq.com/connect/smsauthorize?appid=%@&redirect_uri=%@://oauth&response_type=code&scope=snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact&state=Weixinauth&uid=1&m=%@&t=%@",appid,appid,response[@"m"],response[@"t"]];
            UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            if (rootViewController.presentedViewController) {
                rootViewController = rootViewController.presentedViewController;
            }
            if (rootViewController.childViewControllers.count > 0) {
                for (UIView * view in rootViewController.childViewControllers[0].view.subviews) {
                    if ([view isKindOfClass:[WKWebView class]] && view.tag == 5050) {
                        [(WKWebView *)view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
                        return YES;
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                iCokWebViewController * viewController = [[iCokWebViewController alloc]init];
                viewController.url = url;
                viewController.title = @"微信登录";
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            });
        }else{
            if (dictionary[@"state"]&&[dictionary[@"state"] isEqualToString:@"Weixinauth"]&&[dictionary[@"result"] intValue]!=0) {
                if (_failure) {
                    _failure([NSError errorWithDomain:@"weixin_auth" code:[dictionary[@"result"] intValue] userInfo:dictionary]);
                }
            }else if([dictionary[@"result"] intValue] == 0){
                if (_completeHandler) {
                    _completeHandler(nil);
                }
            }else{
                if (_failure) {
                    _failure([NSError errorWithDomain:@"weixin_share" code:[dictionary[@"result"] intValue] userInfo:dictionary]);
                }
            }
        }
    }
    return YES;
}

+(NSMutableDictionary *)parseUrl:(NSURL*)url{
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [[url query] componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents){
        NSRange range=[keyValuePair rangeOfString:@"="];
        [queryStringDictionary setObject:range.length>0?[keyValuePair substringFromIndex:range.location+1]:@"" forKey:(range.length?[keyValuePair substringToIndex:range.location]:keyValuePair)];
    }
    return queryStringDictionary;
}

@end
