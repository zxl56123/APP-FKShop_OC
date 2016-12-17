//
//  Article.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Article.h"

@implementation Article

- (void)setPropertyWithAttributes:(NSDictionary *)attributes {
	self.id = attributes[@"id"];
	self.title = attributes[@"title"];
	self.supplier = attributes[@"supplier"];
	self.price = attributes[@"price"];
	self.image = attributes[@"image"];
	self.descriptions = attributes[@"description"];
	
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.id forKey:@"id"];
	[aCoder encodeObject:self.title forKey:@"title"];
	[aCoder encodeObject:self.supplier forKey:@"supplier"];
	[aCoder encodeObject:self.price forKey:@"price"];
	[aCoder encodeObject:self.image forKey:@"image"];
	[aCoder encodeObject:self.descriptions forKey:@"description"];
	[aCoder encodeObject:self.buyNum forKey:@"buyNum"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.id = [aDecoder decodeObjectForKey:@"id"];
		self.title = [aDecoder decodeObjectForKey:@"title"];
		self.supplier = [aDecoder decodeObjectForKey:@"supplier"];
		self.price = [aDecoder decodeObjectForKey:@"price"];
		self.image = [aDecoder decodeObjectForKey:@"image"];
		self.descriptions = [aDecoder decodeObjectForKey:@"description"];
		self.buyNum = [aDecoder decodeObjectForKey:@"buyNum"];
	}
	return self;
}
@end
