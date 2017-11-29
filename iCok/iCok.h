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
typedef void (^iCokFailure)(NSError *error);
@interface iCok : NSObject
/**
 微信登录

 @param appid 微信平台appid
 */
+(void)loginWithWXAppId:(NSString *)appid completeHandler:(iCokCompleteHandler)handler failure:(iCokFailure)failure;

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
 判断是否安装了QQ
 
 */
+(BOOL)isQQInstalled;

+(BOOL)openURL:(NSURL *)url;
@end

