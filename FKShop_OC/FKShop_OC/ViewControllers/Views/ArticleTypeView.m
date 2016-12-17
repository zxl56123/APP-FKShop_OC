//
//  ArticleTypeView.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "ArticleTypeView.h"
#import "Common.h"

@implementation ArticleTypeView
- (instancetype)initWithFrame:(CGRect)frame{
	int orderSize = 16;
	if (self = [super initWithFrame:frame]) {
		// 对于iPhone 6s plus
		if (GLOBLE_BOUNDS_WIDTH == 414 && GLOBLE_BOUNDS_HEIGHT == 736){
			orderSize = 16;
			// 对于iPhone 6s
		}else if (GLOBLE_BOUNDS_WIDTH == 375 && GLOBLE_BOUNDS_HEIGHT == 667){
			orderSize = 14;
			// 对于iPhone 5s
		}else if (GLOBLE_BOUNDS_WIDTH == 320 && GLOBLE_BOUNDS_HEIGHT == 568){
			orderSize = 12;
			// 对于iPhone 4s
		}else{
			orderSize = 10;
		}
		NSInteger width = GLOBLE_BOUNDS_WIDTH / 2 - 10;
		// 创建并添加UIImageView控件
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, width,
			GLOBLE_BOUNDS_HEIGHT * 0.3 - 50)];
		// 设置图片保持纵横比缩放
		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.imageView];
		// 创建、并添加UILabel控件
		self.nameLabel = [[UILabel alloc] initWithFrame:
			CGRectMake(0, 10, width, 20)];
		// 设置背景色为透明色
		self.nameLabel.backgroundColor = [UIColor clearColor];
		// 设置文字的字体
		self.nameLabel.font = [UIFont systemFontOfSize:orderSize];
		// 设置居中对齐
		self.nameLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.nameLabel];
		// 为该控件添加边框
		self.layer.borderWidth = 1;
		self.layer.borderColor = [UIColor grayColor].CGColor;
	}
	return self;
}
@end
