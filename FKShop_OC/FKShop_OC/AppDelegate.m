//
//  AppDelegate.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "OrderViewController.h"

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// 注册AppID:该AppID是是App审核后，由微信开放平台提供的
	[WXApi registerApp:@"wx2d7efb543bca8631" withDescription:@"FKShop_OC"];
	return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
			options:(NSDictionary<NSString *, id> *)options{
	return [WXApi handleOpenURL:url delegate:self];
}

// 服务器响应到来时激发该方法
- (void) onResp:(BaseResp*)resp {
	NSString* strTitle = @"";
	NSString* strMsg = @"";
	if( [resp isKindOfClass:SendMessageToWXResp.class] ) {
		strTitle = @"发送媒体消息结果";
	}
	if( [resp isKindOfClass:PayResp.class]) {
		// 支付返回结果，实际支付结果需要去微信服务器端查询
		strTitle = @"支付结果";
		OrderViewController* orderVc = (OrderViewController*)((UINavigationController*)
			self.window.rootViewController).visibleViewController;
		switch (resp.errCode) {
			case 0:
				strMsg = @"恭喜您，支付成功！我们将在48小时内为您安排发货";
				// 处理支付成功的情形
				[orderVc onPaySuccess];
				break;
			default:
				strMsg = [NSString stringWithFormat:@"支付失败！retcode = %d, retstr = %@",
					resp.errCode, resp.errStr];
				NSLog(@"%@" , strMsg);
		}
		[self showAlert:strTitle content: strMsg];
	}
}
// 工具方法，用于调用UIAlertController来显示提示信息
- (void) showAlert:(NSString*)title content: (NSString*)content{
	// 获取当前窗口显示的视图控制器
	UIViewController* vc = ((UINavigationController*)self.window.rootViewController).visibleViewController;
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:
			title message: content preferredStyle: UIAlertControllerStyleAlert];
	[alert addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDestructive handler: nil]];
	// 显示UIAlertController
	[vc presentViewController:alert animated: YES completion: nil];
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
