//
//  ArticleType.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "ArticleType.h"

@implementation ArticleType
- (void)setPropertyWithAttributes:(NSDictionary *)attributes{
	self.code = attributes[@"code"];
	self.name = attributes[@"name"];
}
@end
