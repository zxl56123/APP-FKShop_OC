//
//  ArticleType.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ArticleType : NSObject
@property (nonatomic,strong) NSString* code;
@property (nonatomic,strong) NSString* name;
// 根据字典中的数据设置到对应的属性中
- (void)setPropertyWithAttributes:(NSDictionary *)attributes;
@end
