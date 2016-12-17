//
//  FKNetworkingUtil.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface FKNetworkingUtil : NSObject

/**
 * 异步获取数据
 * @param block block块，用于传递数据
 * @param url 请求URL
 * @param params 请求参数
 * @param clazz 需要封装的类型，通过反射使得该方法可以适用于多个类型的对象
 * 获取的数据设置到NSArray当中
 */
+ (void)getDataWithAsynchronous: (void (^)(NSArray *array))
	block url: (NSString *)url params:(NSDictionary *) params
	clazz: (Class)clazz;

/**
 * 异步获取数据（该方法只用于获取Article数据，因为返回的是一个字典数据）
 * @param block block块，用于传递数据
 * @param url 请求URL
 * @param params 请求参数
 * 获取的数据设置到NSArray当中
 */
+ (void)getArticleDataWithAsynchronous: (void (^)(NSArray *array))
	block url: (NSString *)url params: (NSDictionary *)params;

/**
 * 根据url路径获取网络图片
 * @param path 请求URL
 * @return 获取到的UIImage对象
 */
+ (UIImage *)getImageWithURLPath:(NSString *)path;
@end
