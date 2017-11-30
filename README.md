## iCok.

`无需官方SDK,实现微信、QQ社交功能,支持Web登录`

### Configuration.
如果需要使用`canOpenURL`判断是否安装客户端,则务必添加以下白名单

- `wechat`
- `weixin`
- `mqqOpensdkSSoLogin`
- `mqqopensdkapiV2`
- `mqqwpa`
- `mqqopensdkapiV3`
- `wtloginmqq2`
- `mqq`
- `mqqapi`

添加`URL Schemes`

- `tencent111111111`
- `wxa6711111111`


### Usage

##### `微信登录`

```objective-c
[iCok loginWithWXAppId:@"wxa6711111111" appSecret:@"bb870c004ac64486379341949e17d5b4" completeHandler:^(NSDictionary *response) {
NSLog(@"微信登录成功:%@",response);
} failure:^(NSError *error) {
NSLog(@"微信登录失败:%@",error.description);
}];

```

##### `微信分享`

```objective-c
[iCok shareWithWXAppId:@"wxa6711111111" scene:ICOK_SESSION_TYPE title:@"title" description:@"description" link:@"https://www.github.com" image:[UIImage imageNamed:@"profile"] completeHandler:^(NSDictionary *response) {
NSLog(@"微信分享成功");
} failure:^(NSError *error) {
NSLog(@"微信分享失败:%@",error.description);
}];
```


##### `QQ登录`

```objective-c
[iCok loginWithQQAppId:@"111111111" completeHandler:^(NSDictionary *response) {
NSLog(@"QQ登录成功:%@",response);
} failure:^(NSError *error){
NSLog(@"QQ登录失败:%@",error.description);
}];
```

##### `QQ分享`

```objective-c
[iCok shareWithQQAppId:@"111111111" scene:ICOK_SESSION_TYPE title:@"title" description:@"description" link:@"https://www.github.com" image:[UIImage imageNamed:@"profile"] completeHandler:^(NSDictionary *response) {
NSLog(@"QQ分享成功");
} failure:^(NSError *error) {
NSLog(@"QQ分享失败:%@",error.description);
}];
```
