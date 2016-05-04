//
//  AppDelegate.m
//  ph
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信
#import "WXApi.h"


//新浪
#import "WeiboSDK.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self thirdLogin];
    
    // Override point for customization after application launch.
    return YES;
}
//第三方登录的设置
-(void)thirdLogin{
    [ShareSDK registerApp:@"second"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
//                         case SSDKPlatformTypeWechat:
//                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                             break;
//                             
//                             
//                             
//                         case SSDKPlatformTypeQQ:
//                             [ShareSDKConnector  connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                             break;
                             
                             
                         case  SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                     
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType) {
//                         case SSDKPlatformTypeWechat:
//                             //微信
//                             [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885" appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                             break;
//                             
//                             
//                         case SSDKPlatformTypeQQ:
//                             //QQ
//                             [appInfo SSDKSetupQQByAppId:@"100371282" appKey:@"aed9b0303e3ed1e27bae87c33761161d" authType:SSDKAuthTypeBoth];
//                             break;
                             
////                             
                         case SSDKPlatformTypeSinaWeibo:
//                             新浪
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"1402277092" appSecret:@"a72766b68f466c10c07ccbb002f0ed62" redirectUri:@"http://www.sharesdk.cn"
                            authType:SSDKAuthTypeBoth];
                             break;
                             
                             
                         default:
                             break;
                     }
                     
                     
                     
                 }];
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
