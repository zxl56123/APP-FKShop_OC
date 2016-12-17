//
//  FKUtils.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "FKUtils.h"

@implementation FKUtils

+ (UILabel *)getCustomLaber:(NSString *)text{

	// 创建UILabel
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
	// 设置text
	label.text = text;
	// 设置文本居中对齐
	label.textAlignment = NSTextAlignmentCenter;
	// 设置字体和颜色
	label.font = [UIFont boldSystemFontOfSize:26];
	label.textColor = [UIColor whiteColor];
	return label;
}

+(NSString *)getCurrentIPAddress{
	bool preferIPv4 = YES;
	NSArray *searchArray = preferIPv4 ?
	@[IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
	@[IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
	NSDictionary *addresses = [FKUtils getIP];
	__block NSString* address;
	[searchArray enumerateObjectsUsingBlock:^(NSString *key,
		NSUInteger idx, BOOL *stop){
		address = addresses[key];
		if(address) *stop = YES;
	}];
	return address ? address : @"0.0.0.0";
}

+(NSDictionary *)getIP{
	NSMutableDictionary *addresses = [NSMutableDictionary
		dictionaryWithCapacity:8];
	struct ifaddrs *interfaces;
	if(!getifaddrs(&interfaces)) {
		struct ifaddrs *interface;
		for(interface = interfaces; interface; interface = interface->ifa_next) {
			if(!(interface->ifa_flags & IFF_UP) ||
			   (interface->ifa_flags & IFF_LOOPBACK)) {
				continue;
			}
			const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
			if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
				NSString *name = @(interface->ifa_name);
				char addrBuf[INET6_ADDRSTRLEN];
				if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
					NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
					addresses[key] = @(addrBuf);
				}
			}
		}
		freeifaddrs(interfaces);
	}
	return addresses.count ? addresses : nil;
}
@end
