//
//  ShopCarTableViewCell.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "ShopCarTableViewCell.h"

@implementation ShopCarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(NSString *)reuseIdentifier{
	if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// 创建和添加UIImageView控件
		self.articleImageView = [[UIImageView alloc]
			initWithFrame:CGRectMake(0, 5, GLOBLE_BOUNDS_WIDTH * 0.3,
			GLOBLE_BOUNDS_HEIGHT * 0.16)];
		// 设置UIImageView显示的图片保持纵横比缩放
		self.articleImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.articleImageView];
		// 创建和添加UILabel控件
		self.titleLabel = [[UILabel alloc] initWithFrame:
			CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.3 + 5, 0,
			GLOBLE_BOUNDS_WIDTH * 0.42 , GLOBLE_BOUNDS_HEIGHT * 0.11)];
		// 设置背景色
		self.titleLabel.backgroundColor = [UIColor clearColor];
		// 设置字体和颜色
		self.titleLabel.font = [UIFont systemFontOfSize:15];
		self.titleLabel.textColor = [UIColor blackColor];
		// 设置居左对齐
		self.titleLabel.textAlignment = NSTextAlignmentLeft;
		// 设置最多显示3行
		self.titleLabel.numberOfLines = 3;
		[self addSubview:self.titleLabel];
		// 创建和添加UILabel控件
		self.supplierLabel = [[UILabel alloc] initWithFrame:CGRectMake(
			GLOBLE_BOUNDS_WIDTH * 0.3 + 5, GLOBLE_BOUNDS_WIDTH * 0.2,
			GLOBLE_BOUNDS_WIDTH * 0.3, GLOBLE_BOUNDS_HEIGHT * 0.05)];
		// 设置背景色
		self.supplierLabel.backgroundColor = [UIColor clearColor];
		// 设置字体和颜色
		self.supplierLabel.font = [UIFont systemFontOfSize:18];
		self.supplierLabel.textColor = [UIColor grayColor];
		// 设置居左对齐
		self.supplierLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.supplierLabel];
		// 创建和添加UILabel控件
		self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(GLOBLE_BOUNDS_WIDTH - 90, 10, 200 , 30)];
		// 设置背景色
		self.priceLabel.backgroundColor = [UIColor clearColor];
		// 设置字体和颜色
		self.priceLabel.font = [UIFont systemFontOfSize:18];
		self.priceLabel.textColor = [UIColor redColor];
		// 设置居左对齐
		self.priceLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.priceLabel];
		// 创建和添加UILabel控件
		self.buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(
			GLOBLE_BOUNDS_WIDTH - 70, 40, 200, 30)];
		// 设置背景色
		self.buyNumLabel.backgroundColor = [UIColor clearColor];
		// 设置字体和颜色
		self.buyNumLabel.font = [UIFont systemFontOfSize:18];
		self.buyNumLabel.textColor = [UIColor blackColor];
		// 设置居左对齐
		self.buyNumLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.buyNumLabel];
		// 为该控件设置边框
		self.layer.borderWidth = 1;
		self.layer.borderColor = [UIColor grayColor].CGColor;
	}
	return self;
}
@end
