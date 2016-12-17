//
//  ArticleTableViewCell.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//


#import "Common.h"
#import "ArticleTableViewCell.h"



@implementation ArticleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(nullable NSString *)reuseIdentifier{
	int fontSize = 12;
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// 对于iPhone 6s plus
		if (GLOBLE_BOUNDS_WIDTH == 414 && GLOBLE_BOUNDS_HEIGHT == 736){
			fontSize = 17;
		// 对于iPhone 6s
		}else if (GLOBLE_BOUNDS_WIDTH == 375 && GLOBLE_BOUNDS_HEIGHT == 667){
			fontSize = 15;
		// 对于iPhone 5s
		}else if (GLOBLE_BOUNDS_WIDTH == 320 && GLOBLE_BOUNDS_HEIGHT == 568){
			fontSize = 13;
		// 对于iPhone 4s
		}else{
			fontSize = 12;
		}
		self.backgroundColor=[UIColor clearColor];
		// 创建、并添加UIImageView控件
		self.articleImageView = [[UIImageView alloc]
			initWithFrame:CGRectMake(0, 5, GLOBLE_BOUNDS_WIDTH * 0.4,
			GLOBLE_BOUNDS_HEIGHT * 0.21)];
		self.articleImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.articleImageView];
		// 创建、并添加UILabel控件
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake
			(GLOBLE_BOUNDS_WIDTH * 0.4, 0, GLOBLE_BOUNDS_WIDTH * 0.57 , 60)];
		// 设置背景色
		self.titleLabel.backgroundColor = [UIColor clearColor];
		// 设置字体
		self.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
		// 设置居左对齐
		self.titleLabel.textAlignment = NSTextAlignmentLeft;
		// 设置最多显示3行
		self.titleLabel.numberOfLines = 3;
		[self addSubview:self.titleLabel];
		// 创建、并添加UILabel对象
		self.supplierLabel = [[UILabel alloc] initWithFrame:CGRectMake(
			GLOBLE_BOUNDS_WIDTH * 0.4, GLOBLE_BOUNDS_HEIGHT * 0.15,
			GLOBLE_BOUNDS_WIDTH * 0.6, 10)];
		// 设置背景色
		self.supplierLabel.backgroundColor = [UIColor clearColor];
		// 设置字体和颜色
		self.supplierLabel.font = [UIFont boldSystemFontOfSize:fontSize];
		self.supplierLabel.textColor = [UIColor grayColor];
		// 设置居左对齐
		self.supplierLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.supplierLabel];
		// 创建、并添加UILabel对象
		self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(
			 GLOBLE_BOUNDS_WIDTH * 0.4, GLOBLE_BOUNDS_HEIGHT * 0.2,
			 GLOBLE_BOUNDS_WIDTH * 0.6, 10)];
		// 设置背景色
		self.priceLabel.backgroundColor = [UIColor clearColor];
		// 设置字体和颜色
		self.priceLabel.font = [UIFont boldSystemFontOfSize:fontSize];
		self.priceLabel.textColor = [UIColor redColor];
		// 设置居左对齐
		self.priceLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.priceLabel];
		// 为该自定义的表格行控件添加边框
		self.layer.borderWidth = 1;
		self.layer.borderColor = [UIColor grayColor].CGColor;
	}
	return self;
}
@end
