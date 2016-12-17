//
//  FKNetworkingUtil.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//
#import "FKNetworkingUtil.h"
#import "AFNetworking.h"
#import "Article.h"

@implementation FKNetworkingUtil
+ (void)getDataWithAsynchronous: (void (^)(NSArray *array))
	block url:(NSString *) url params:(NSDictionary *) params
	clazz: (Class)clazz {
	// 创建AFHTTPSessionManager对象，默认是JSON解析器
	AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
	// 使用AFHTTPSessionManager发送POST请求，
	// 返回的responseObject会自动转成数组或字典
	[manager POST:url parameters:params progress:nil success:
		^(NSURLSessionDataTask* task, id responseObject) {
		// 创建一个数组保存数据
		NSMutableArray *array = [NSMutableArray
			arrayWithCapacity:[responseObject count]];
		// 循环将获取到的数据保存到动态创建的对象中，并添加到一个集合
		for (NSDictionary* attributes in responseObject) {
			// 动态创建对象
			id instance = [[clazz alloc] init];
			// 动态调用方法setPropertyWithAttributes:
			[instance performSelector:@selector(setPropertyWithAttributes:) withObject:attributes];
			// 添加到集合
			[array addObject:instance];
		}
		// 将结果设置到block当中返回
		block(array);
	}
		// 获取服务器响应失败时激发的代码块
		failure:^(NSURLSessionDataTask* task, NSError *error) {
			NSLog(@"异步获取数据失败 %@",error);
	}];
}

+ (void)getArticleDataWithAsynchronous: (void (^)(NSArray *array))
	block url: (NSString *)url params: (NSDictionary *)params {
	AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
	[manager POST:url parameters:nil progress:nil success:
		^(NSURLSessionDataTask* task, id responseObject) {
		// 获得items数据
		NSArray *items = [responseObject valueForKey:@"items"];
		// 创建一个数组保存数据
		NSMutableArray *mutableArray = [[NSMutableArray alloc]
			initWithCapacity:items.count];
		// 循环遍历
		for (NSDictionary *attributes in items) {
			// 创建Article对象封装数据
			Article* article = [[Article alloc] init];
			[article setPropertyWithAttributes:attributes];
			// 添加到集合
			[mutableArray addObject:article];
		}
		// 传递数据
		block(mutableArray);
	}
		failure:^(NSURLSessionDataTask* task, NSError *error) {
			NSLog(@"%@",error);
	}];
}

+ (UIImage *)getImageWithURLPath:(NSString *)path{
	// 定义代表网络图片的NSURL
	NSURL *url = [NSURL URLWithString:path];
	// 获得NSData
	NSData *data = [NSData dataWithContentsOfURL:url];
	// 创建UIImage
	UIImage* image = [UIImage imageWithData:data];
	// 设置图片的绘制模式:只是绘制原始图片
	image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	return image;
}
@end
