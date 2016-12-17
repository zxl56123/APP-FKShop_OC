//
//  ArticleTypeTableViewCell.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "ArticleTypeTableViewCell.h"
#import "Common.h"

@implementation ArticleTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(nullable NSString *)reuseIdentifier{
	if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// 定义宽度
		NSInteger width = GLOBLE_BOUNDS_WIDTH / 2;
		// 创建第一个自定义的ArticleTypeView控件
		self.view1 = [[ArticleTypeView alloc] initWithFrame:
			CGRectMake(0, 0, width, GLOBLE_BOUNDS_HEIGHT * 0.3)];
		// 添加第一个控件
		[self.contentView addSubview:self.view1];
		// 创建第二个自定义的ArticleTypeView控件
		self.view2 = [[ArticleTypeView alloc] initWithFrame:
			CGRectMake(width, 0, width, GLOBLE_BOUNDS_HEIGHT * 0.3)];
		// 添加第二个控件
		[self.contentView addSubview:self.view2];
	}
	return self;
}
@end
