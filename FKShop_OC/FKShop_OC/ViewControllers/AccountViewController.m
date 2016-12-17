//
//  AccountViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "FKUtils.h"
#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		UIImage* unselectImage = [[UIImage imageNamed:ACCOUNTRNMPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage* selectImage = [[UIImage imageNamed:ACCOUNTONPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"疯狂软件" image:unselectImage selectedImage:selectImage];
		item.tag = 3;
		self.tabBarItem = item;
	}
	return self;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	// 创建和添加显示“关于我们”的UILabel控件
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(
		0, 0, GLOBLE_BOUNDS_WIDTH, 30)];
	// 背景颜色
	titleLabel.backgroundColor = [UIColor grayColor];
	// 设置字体
	titleLabel.font = [UIFont systemFontOfSize:25];
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.text = @"关于我们";
	// 添加边框和并设置边框颜色
	titleLabel.layer.borderWidth = 1;
	titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
	[self.view addSubview:titleLabel];
	// 创建和添加显示logo的UIImageView控件
	UIImage *logo = [UIImage imageNamed:@"logo108.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.15,GLOBLE_BOUNDS_HEIGHT * 0.08, 100 , 50)];
	imageView.image = logo;
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:imageView];
	// 创建和添加显示网址的UILabel控件
	UILabel *urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.42,GLOBLE_BOUNDS_HEIGHT * 0.09,
		GLOBLE_BOUNDS_WIDTH , 40)];
	// 设置字体
	urlLabel.font = [UIFont systemFontOfSize:22];
	// 设置居左对齐
	urlLabel.textAlignment = NSTextAlignmentLeft;
	urlLabel.text = @"www.fkit.org";
	[self.view addSubview:urlLabel];
	// 创建和添加显示“商家简介”的UITextView控件
	UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.05 , GLOBLE_BOUNDS_HEIGHT * 0.19,
		GLOBLE_BOUNDS_WIDTH * 0.9 , 250)];
	// 设置背景色
	textView.backgroundColor = [UIColor colorWithRed:220
		green:220 blue:220 alpha:0.5];
	// 设置字体
	textView.font = [UIFont systemFontOfSize:16];
	// 读取指定文件的内容，并使用textView控件显示文件内容
	NSBundle* bundle = [NSBundle mainBundle];
	NSString* path = [bundle pathForResource:@"fkjava" ofType:@"txt"];
	textView.text = [NSString stringWithContentsOfFile: path
		encoding: NSUTF8StringEncoding error:nil];
	// 添加边框和并设置边框颜色
	textView.layer.borderWidth = 1;
	textView.layer.borderColor = [UIColor blackColor].CGColor;
	[self.view addSubview:textView];
	// 创建和添加显示版权信息的UILabel控件
	UILabel *copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.28,GLOBLE_BOUNDS_HEIGHT * 0.62, 200 , 30)];
	// 设置字体
	copyrightLabel.font = [UIFont systemFontOfSize:15];
	copyrightLabel.textAlignment = NSTextAlignmentLeft;
	copyrightLabel.text = @"copyright©2010-2016";
	[self.view addSubview:copyrightLabel];
	// 创建和添加显示商家名称的UILabel控件
	UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.25,GLOBLE_BOUNDS_HEIGHT * 0.65, 300 , 30)];
	// 设置字体
	companyLabel.font = [UIFont systemFontOfSize:15];
	companyLabel.textAlignment = NSTextAlignmentLeft;
	companyLabel.text = @"广州为学教育科技有限公司";
	[self.view addSubview:companyLabel];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
