//
//  iCok.h
//  iCok
//
//  Created by Nelson on 2017/11/27.
//  Copyright © 2017年 Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,iCokSceneType) {
    ICOK_SESSION_TYPE,
    ICOK_TIMELINE_TYPE
};
typedef void (^iCokCompleteHandler)(NSDictionary *response);
typedef void (^payResponse)(NSInteger errorCode , NSString * msg);
typedef void (^iCokFailure)(NSError *error);
@interface iCok : NSObject
/**
 微信登录

 @param appid 微信平台appid
 @param secret 微信平台appSecret
 */
+(void)loginWithWXAppId:(NSString *)appid appSecret:(NSString *)secret completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure;


/**
 微信支付

 @param appId 微信平台appid
 @param partnerId 商家id
 @param prepayId 预支付订单
 @param nonceStr 随机串,妨重发
 @param timeStamp 时间戳,妨重发
 @param package 商家根据财付通文档填写的数据和签名
 @param sign 商家根据微信开放平台文档对数据做的签名
 @param handler errorCode为0标识成功,非0则失败
 */
+(void)payWithWXAppId:(NSString *)appId partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId nonceStr:(NSString *)nonceStr timeStamp:(NSString *)timeStamp package:(NSString *)package sign:(NSString *)sign completedHandler:(payResponse)handler;

/**
 微信分享
 
 @param appid 微信平台appid
 @param scene 场景
 @param title 标题
 @param description 描述
 @param link 链接
 @param image UIImage对象
 */

+(void)shareWithWXAppId:(NSString *)appid scene:(iCokSceneType)scene title:(NSString *)title description:(NSString *)description link:(NSString *)link image:(UIImage *)image completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure;
/**
 判断是否安装了微信
 
 */
+(BOOL)isWeChatInstalled;

/**
 QQ登录

 @param appid QQ平台appid
 */
+(void)loginWithQQAppId:(NSString *)appid completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure;

/**
 QQ分享

 @param appid QQ平台appid
 @param scene 场景
 @param title 标题
 @param description 描述
 @param link 链接
 @param image UIImage对象
 */
+(void)shareWithQQAppId:(NSString *)appid scene:(iCokSceneType)scene title:(NSString *)title description:(NSString *)description link:(NSString *)link image:(UIImage *)image completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure;

/**
 判断是否安装了QQ
 
 */
+(BOOL)isQQInstalled;

+(BOOL)openURL:(NSURL *)url;
@end

