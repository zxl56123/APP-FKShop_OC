//
//  ArticleViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "FKUtils.h"
#import "FKNetworkingUtil.h"
#import "ArticleViewController.h"
#import "Article.h"
#import "ArticleTableViewCell.h"
#import "DetailViewController.h"

@interface ArticleViewController () <UITableViewDataSource, UITableViewDelegate>
@end
@implementation ArticleViewController{
	NSArray *_articleArray;  // UITableView需要显示的数据
	MBProgressHUD *_hud;	 // 提示控件
	UITableView *_tableView;  // 显示数据的UITableView
}
- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.titleView = [FKUtils getCustomLaber:@"物品分类"];
	// 创建UITableView
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
		GLOBLE_BOUNDS_WIDTH, GLOBLE_BOUNDS_HEIGHT - 84)
		style:UITableViewStylePlain];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	// 设置行高
	_tableView.rowHeight = GLOBLE_BOUNDS_HEIGHT * 0.23;
	// tableview隐藏多余的分割线，tableview没有数据的时候不显示线
	_tableView.tableFooterView = [[UIView alloc] init];
	[self.view addSubview:_tableView];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	// 创建提示控件
	_hud = [[MBProgressHUD alloc] init];
	// 设置提示控件信息
	_hud.labelText = @"正在载入网络数据...";
	// 显示提示控件
	[_hud show:YES];
	// 将提示控件添加到视图上
	[self.view addSubview:_hud];
	NSString *url = [NSString stringWithFormat:@"%@%@"
		, ARTICLE_ACTION,self.code];
	// 异步请求数据
	[FKNetworkingUtil getArticleDataWithAsynchronous:^(NSArray *array) {
		// 获取数据
		_articleArray = array;
		// 移除_hud控件
		[_hud removeFromSuperview];
		// 刷新_tableView显示的数据
		[_tableView reloadData];
	} url:url params:nil];
}
// 返回各分区内包含的表格行的数量（_articleArray数组有多少个元素，就显示多少个表格行）
- (NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section{
	return _articleArray.count;
}
// 返回每行的单元格,提供 tableView 中显示的数据
- (UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString* cellID = @"cellID";
	ArticleTableViewCell *cell = [tableView
		dequeueReusableCellWithIdentifier:cellID];
	// 如果cell为空，则创建自定义的ArticleTableViewCell表格行控件
	if(!cell){
		cell = [[ArticleTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
	}
	// 根据行号获得对应的Article对象
	Article* article = _articleArray[indexPath.row];
	// 网络读取图片数据
	NSString* imageURL = [NSString stringWithFormat:@"%@%@",
		FKSHOP_IMAGES_ARTICLE, article.image];
	UIImage *image = [FKNetworkingUtil getImageWithURLPath:imageURL];
	// 设置图片
	cell.articleImageView.image = image;
	// 设置商品标题
	cell.titleLabel.text = article.title;
	// 设置商品供应商
	cell.supplierLabel.text = article.supplier;
	// 设置商品的价格，保留两位小数
	cell.priceLabel.text = [NSString stringWithFormat:@"￥：%.2lf",
		article.price.doubleValue];
	return cell;
}
// 当选中某个表格行时激发该方法
- (void)tableView:(UITableView *)tableView
	didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	// 获取商品信息
	Article *article = _articleArray[indexPath.row];
	// 创建宝贝详情视图
	DetailViewController* detailViewController =
		[[DetailViewController alloc] init];
	// 传递商品信息
	detailViewController.article = article;
	// 显示指定商品详情的视图控制器
	[self.navigationController pushViewController:detailViewController
		animated:YES];	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
