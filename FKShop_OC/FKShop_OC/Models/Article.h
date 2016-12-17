//
//  Article.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ArticleType.h"

@interface Article : NSObject<NSCoding>
// id
@property (nonatomic, strong) NSString *id;
// 标题
@property (nonatomic, strong) NSString *title;
// 供应商
@property (nonatomic, strong) NSString *supplier;
// 价格
@property (nonatomic, strong) NSNumber *price;
// 封面
@property (nonatomic, strong) NSString *image;
// 描述
@property (nonatomic, strong) NSString *descriptions;
// 购买数量
@property (nonatomic, strong) NSString *buyNum;
// 根据字典中的数据设置到对应的属性当中
- (void)setPropertyWithAttributes:(NSDictionary *)attributes;
// 当程序归档对象时调用该方法
- (void)encodeWithCoder:(NSCoder *)aCoder;
// 当程序恢复对象时调用该方法
- (id)initWithCoder:(NSCoder *)aDecoder;
@end
