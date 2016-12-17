//
//  HotViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "FKUtils.h"
#import "HotViewController.h"
#import "DetailViewController.h"
#import "FKNetworkingUtil.h"
#import "Article.h"
#import "ArticleTypeTableViewCell.h"
#import "ArticleTypeView.h"

#define imageCount 5
#define rowCellCount 2
#define hotItemCount 6 // 热点数据最多只显示6条
#define scrollViewHeight GLOBLE_BOUNDS_HEIGHT * 0.25
@interface HotViewController () <UIScrollViewDelegate,
	UITableViewDataSource>
@end
@implementation HotViewController{
	UIPageControl * _pageControl;  // 分页控件
	NSArray * _articleArray;  // UITableView需要显示的数据
	MBProgressHUD * _hud;  // 提示控件
	UITableView * _tableView;  // 显示数据的UITableView
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		// 获取该选项卡底部选项按钮未选中时的图片
		UIImage* unselectImage = [[UIImage imageNamed:HOMENMPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 获取该选项卡底部选项按钮选中时的图片
		UIImage* selectImage = [[UIImage imageNamed:HOMEONPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 创建一个UITabBarItem
		UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"主页"
			image:unselectImage selectedImage:selectImage];
		// 设置tag
		item.tag = 0;
		// 将创建的UITabBarItem设置为视图控制器的TabBarItem
		self.tabBarItem = item;
	}
	return self;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	/******************界面上方显示轮播的5张广告图片******************/
	// 创建一个滚动视图
	UIScrollView *scrollView = [[UIScrollView alloc]
		initWithFrame:CGRectMake(0, 0, GLOBLE_BOUNDS_WIDTH, scrollViewHeight)];
	// 开启分页设置
	scrollView.pagingEnabled = YES;
	// 设置滚动视图的contentSize为滚动视图的宽度*5，因为有5张图片
	scrollView.contentSize = CGSizeMake(GLOBLE_BOUNDS_WIDTH * imageCount, scrollViewHeight);
	// 设置代理
	scrollView.delegate = self;
	// 当前视图控制器添加滚动视图
	[self.view addSubview:scrollView];
	// 添加图片: 显示服务器端的img1.png、img2.png...img5.png5张滚动的广告图片
	for (int i = 0; i < imageCount; i++) {
		NSString* path = [NSString stringWithFormat:@"%@img%d.png",
			FKSHOP_IMAGES ,i + 1];
		UIImage* image = [FKNetworkingUtil getImageWithURLPath:path];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		// 设置UIImageView的大小和位置
		imageView.frame = CGRectMake(GLOBLE_BOUNDS_WIDTH * i,
			0, GLOBLE_BOUNDS_WIDTH, scrollView.frame.size.height);
		// 向滚动视图中添加UIImageView
		[scrollView addSubview:imageView];
	}
	// 创建分页控件
	_pageControl = [[UIPageControl alloc] init];
	// 设置选中页的圆点颜色
	_pageControl.currentPageIndicatorTintColor = [UIColor redColor];
	// 设置非选中页的圆点颜色
	_pageControl.pageIndicatorTintColor = [UIColor grayColor];
	// 一共显示多少页（圆点）
	_pageControl.numberOfPages = imageCount;
	// 设置分页控件的中心点,x轴为滚动视图中心，y轴为滚动视图高度的0.95
	_pageControl.center = CGPointMake(GLOBLE_BOUNDS_WIDTH * 0.5,
		scrollView.frame.size.height * 0.95);
	// 将分页控件添加到视图上
	[self.view addSubview:_pageControl];
	/******************界面下方显示热销商品的表格******************/
	// 创建UITableView，其高度为屏幕高度减去上方滚动区高度、导航栏高度和状态栏高度
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, scrollViewHeight, GLOBLE_BOUNDS_WIDTH, GLOBLE_BOUNDS_HEIGHT - scrollViewHeight - 64 - 20)
		style:UITableViewStylePlain];
	_tableView.dataSource = self;
	// 设置行高
	_tableView.rowHeight = GLOBLE_BOUNDS_HEIGHT * 0.3;
	// 设置分割线
	_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	// tableview隐藏多余的分割线，tableview没有数据的时候不显示线
	_tableView.tableFooterView = [[UIView alloc] init];
	// 将tableView添加到视图上
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
	/******************获取网络数据******************/
	// 异步请求数据
	[FKNetworkingUtil getArticleDataWithAsynchronous:^(NSArray *array) {
		// 获取数据
		_articleArray = array;
		// 网络数据加载完成，删除_hud控件
		[_hud removeFromSuperview];
		// 刷新_tableView
		[_tableView reloadData];
	} url:ARTICLE_ACTION params:nil];
}
// UIScrollView滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	// 设置pageControl的当前页，则当前页的圆点颜色会变化
	_pageControl.currentPage = scrollView.contentOffset.x /
		scrollView.frame.size.width;
}
// 返回指定分区内的表格行数
- (NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section{
	// 热点数据最多只显示6条
	NSInteger realItemCount = hotItemCount < _articleArray.count ?
		hotItemCount : _articleArray.count;
	return realItemCount == 0 ? 0 : (realItemCount - 1) / rowCellCount + 1 ;
}
// 返回表格内每个单元格的控件
- (UITableViewCell *)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString* cellID = @"cellID";
	// 自定义UITableViewCell
	ArticleTypeTableViewCell *cell = [tableView
		dequeueReusableCellWithIdentifier:cellID];
	// 使用自定义单元格
	if(!cell){
		cell = [[ArticleTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
	}
	// 当前行数
	NSInteger row = indexPath.row;
	// 定义一个Article对象
	Article* article = nil;
	// 一列放置两个商品，所以循环两次
	for (int i = 0; i < rowCellCount; i++) {
		// 如果列数量*2+i 大于 数组的长度 - 1 ，说明没有数据了，退出
		// 第一次 0*2+0 > 14 -1
		// 最后一次 7*2+0 > 14 -1
		if (row * rowCellCount + i > _articleArray.count) {
			break;
		}
		// 根据行数获得对应的Article对象
		article = _articleArray[row * rowCellCount + i];
		// 类型图片
		NSString* imageURL = [NSString stringWithFormat:@"%@%@",
			FKSHOP_IMAGES_ARTICLE, article.image];
		UIImage* image = [FKNetworkingUtil getImageWithURLPath:imageURL];
		// 点击的手势处理器，点击时调用cellViewTapped方法
		UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]
			initWithTarget:self action:@selector(cellViewTapped:)];
		// i == 0 放置在列的第一个视图，否则放第二个视图
		if (i == 0) {
			cell.view1.imageView.image = image;
			cell.view1.nameLabel.text = article.title;
			cell.view1.article = article;
			// 为表格行内包含的视图添加手势处理器。
			// 添加手势处理器之后表格不会再响应“表格行被选中”的事件
			[cell.view1 addGestureRecognizer:recognizer];  // ①
		}else{
			cell.view2.imageView.image = image;
			cell.view2.nameLabel.text = article.title;
			cell.view2.article = article;
			[cell.view2 addGestureRecognizer:recognizer];  // ②
		}
	}
	return cell;
}
// 手势点击时的处理方法
- (void) cellViewTapped:(UITapGestureRecognizer *)recognizer{
	// 获得点击的视图
	ArticleTypeView *view = (ArticleTypeView *)recognizer.view;
	// 创建商品详情视图
	DetailViewController* detailViewController =
		[[DetailViewController alloc] init];
	// 将点击选中的商品code传递给类型视图控制器
	detailViewController.article = view.article;
	// 显示商品详情的视图
	[self.navigationController pushViewController:detailViewController
		animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
