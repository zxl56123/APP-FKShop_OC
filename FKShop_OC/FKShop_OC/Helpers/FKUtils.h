//
//  FKUtils.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//
#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#define IOS_CELLULAR	@"pdp_ip0"
#define IOS_WIFI		@"en0"
#define IP_ADDR_IPv4	@"ipv4"
#define IP_ADDR_IPv6	@"ipv6"

@interface FKUtils : NSObject

/**
 * 自定义Label
 * @param text Label的text
 * @return 获取到的UILabel对象
 */
+ (UILabel *)getCustomLaber:(NSString *)text;
// 获取当前主机的IP地址
+ (NSString *)getCurrentIPAddress;

+ (NSDictionary *)getIP;

@end
