//
//  ShopCarViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//


#import "Common.h"
#import "FKUtils.h"
#import "FKNetworkingUtil.h"
#import "ShopCarViewController.h"
#import "ShopCarTableViewCell.h"
#import "Article.h"
#import "OrderViewController.h"

@interface ShopCarViewController ()<UITableViewDataSource>

@end

@implementation ShopCarViewController {
	NSArray * _shopCar; // 购物车
	double _sumPrice;
	UILabel *_sumPriceLabel;
	UITableView *_tableView;
	UIButton* _btnBuy;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		UIImage* unselectImage = [[UIImage imageNamed:SHOPCARNMPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage* selectImage = [[UIImage imageNamed:SHOPCARONPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:@"购物车"
			image:unselectImage selectedImage:selectImage];
		item.tag = 2;
		self.tabBarItem = item;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	// 创建和添加显示“我的购物车”的UILabel控件
	UILabel* titleLabel = [[UILabel alloc] initWithFrame:
		CGRectMake(0, 0, GLOBLE_BOUNDS_WIDTH, 30)];
	// 设置背景色
	titleLabel.backgroundColor = [UIColor grayColor];
	// 设置字体和颜色
	titleLabel.font = [UIFont systemFontOfSize:20];
	titleLabel.textAlignment = NSTextAlignmentLeft;
	titleLabel.text = @"我的购物车";
	// 添加边框和并设置边框颜色
	titleLabel.layer.borderWidth = 1;
	titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
	[self.view addSubview:titleLabel];
	 // 创建和添加显示合计信息的UILabel控件
	_sumPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 42, 250, 25)];
	// 设置背景色
	_sumPriceLabel.backgroundColor = [UIColor clearColor];
	// 设置字体和颜色
	_sumPriceLabel.font = [UIFont systemFontOfSize:22];
	_sumPriceLabel.textColor = [UIColor redColor];
	// 设置居左对齐
	_sumPriceLabel.textAlignment = NSTextAlignmentLeft;
	_sumPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf", _sumPrice];
	[self.view addSubview:_sumPriceLabel];
	// 创建和添加“结算”的按钮
	_btnBuy = [UIButton buttonWithType:UIButtonTypeSystem];
	// 设置大小和位置位置
	_btnBuy.frame = CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.7, 38,
		GLOBLE_BOUNDS_WIDTH * 0.23, GLOBLE_BOUNDS_HEIGHT * 0.05);
	UIImage* submitImage = [UIImage imageNamed:SUBMITPNG];
	// 设置图片背景（使用美工提供的按钮图片）
	[_btnBuy setBackgroundImage:submitImage
		forState:UIControlStateNormal];
	[_btnBuy addTarget:self action:@selector(onAddOrder:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_btnBuy];
	// 创建UITableView
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80,
		GLOBLE_BOUNDS_WIDTH - 20, GLOBLE_BOUNDS_HEIGHT - 168)
		style:UITableViewStylePlain];
	// 设置分割线
	_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	// 设置表格隐藏多余的分割线，表格没有数据的时候不显示线
	_tableView.tableFooterView = [[UIView alloc] init];
	_tableView.dataSource = self;
	// 设置行高，和自定义表格行的高度保持一致
	_tableView.rowHeight = GLOBLE_BOUNDS_HEIGHT * 0.18;
	[self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	// 购物车数据
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSDictionary * dict = [userDefaults objectForKey:SHOP_CAR];
	if (dict == nil) {
		_btnBuy.enabled = false;
		return;
	}
	_shopCar = dict.allValues;
	// 合计
	_sumPrice = 0;
	// 遍历购物车
	for (NSData * data in _shopCar) {
		// 恢复数据
		Article* article = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		double price = article.price.doubleValue; // 获取商品的价格
		int buyNum = article.buyNum.intValue; // 获取商品的数量
		_sumPrice += price * buyNum;
	}
	_btnBuy.enabled = _sumPrice > 0;
	_sumPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf", _sumPrice];
	[_tableView reloadData];
}
// 返回各分区内包含的表格行的数量（_shopcar数组有多少个元素，就显示多少个表格行）
- (NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section{
	return [_shopCar count];
}

// 返回表格内每个单元格的控件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	// 为表格行定义一个静态字符串作为可重用标识符
	static NSString* cellID = @"cellID";
	// 根据重用标示符从UITableView管理的“可重用单元格队列”中取出一个UITableViewCell对象
	ShopCarTableViewCell* cell = [tableView
		dequeueReusableCellWithIdentifier:cellID];
	// 如果取出的UITableViewCell对象为空，则创建一个，并指定重用标示符
	if (!cell) {
		cell = [[ShopCarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
	}
	NSData * data = _shopCar[indexPath.row];
	// 恢复商品对象
	Article* article = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	// 网络读取图片数据
	NSString* imageURL = [NSString stringWithFormat:@"%@%@",
		FKSHOP_IMAGES_ARTICLE, article.image];
	UIImage* image = [FKNetworkingUtil getImageWithURLPath:imageURL];
	cell.articleImageView.image = image;
	cell.titleLabel.text = article.title;
	cell.supplierLabel.text = article.supplier;
	cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2lf",
		[article.price doubleValue]];
	cell.buyNumLabel.text = [NSString stringWithFormat:@"×%@",
		article.buyNum];
	return cell;
}
// 为“结算”按钮添加事件处理方法
- (void)onAddOrder:(id) sender {
	// 创建订单详情视图控制器
	OrderViewController* orderViewController =
		[[OrderViewController alloc] init];
	// 显示订单详情的视图控制器
	[self.navigationController
		pushViewController:orderViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end