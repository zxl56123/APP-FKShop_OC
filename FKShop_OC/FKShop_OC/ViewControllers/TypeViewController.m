//
//  TypeViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "FKUtils.h"
#import "TypeViewController.h"
#import "ArticleViewController.h"
#import "FKNetworkingUtil.h"
#import "ArticleType.h"
#import "ArticleTypeTableViewCell.h"
#import "ArticleTypeView.h"

@interface TypeViewController () <UITableViewDataSource>

@end
#define rowCellCount 2

@implementation TypeViewController {
	NSArray *_articleTypeArray;  // UITableView需要显示的数据
	UITableView *_tableView;  // 显示数据的UITableView
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		UIImage* unselectImage = [[UIImage imageNamed:TYPENMPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage* selectImage = [[UIImage imageNamed:TYPEONPNG]
			imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 创建一个UITabBarItem
		UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:@"分类"
			image:unselectImage selectedImage:selectImage];
		item.tag = 1;
		// 将创建的UITabBarItem设置为视图控制器的TabBarItem
		self.tabBarItem = item;
	}
	return self;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	// 创建、并添加所有类别的UITableView控件
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GLOBLE_BOUNDS_WIDTH, GLOBLE_BOUNDS_HEIGHT - 108)
		style:UITableViewStylePlain];
	_tableView.dataSource = self;
	// 设置行高
	_tableView.rowHeight = GLOBLE_BOUNDS_HEIGHT * 0.3;
	// 设置分割线
	_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	// 设置表格隐藏多余的分隔线，表格没有数据的时候不显示多余的分隔线
	_tableView.tableFooterView = [[UIView alloc] init];
	[self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	// 异步获取数据
	[FKNetworkingUtil getDataWithAsynchronous:^(NSArray *array) {
		// 获取数据
		_articleTypeArray = array;
		// 刷新_tableView数据
		[_tableView reloadData];
	} url:ARTICLETYPE_ACTION params:nil clazz:ArticleType.class];
}
// 返回指定分区内表格行的数量
- (NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section{
	// 因为每行显示两个类型，因此需要除以rowCellCount
	return (_articleTypeArray.count - 1) / rowCellCount + 1;
}
// 返回每行的单元格,提供 tableView 中显示的数据
- (UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString* cellID = @"cellID";
	// 自定义UITableViewCell
	ArticleTypeTableViewCell *cell = [tableView
		dequeueReusableCellWithIdentifier:cellID];
	if(!cell){
		cell = [[ArticleTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
	}
	// 当前行数
	NSInteger row = indexPath.row;
	// 定义一个ArticleType对象
	ArticleType* articleType = nil;
	// 由于每行显示两个类型，所以循环两次
	for (int i = 0; i < rowCellCount; i++) {
		// 如果行数量 * 2 + i > 数组的长度 - 1，说明没有数据了，退出循环
		if (row * rowCellCount + i > _articleTypeArray.count) {
			break;
		}
		// 根据行数获得本行显示的ArticleType
		articleType = _articleTypeArray[row * rowCellCount + i];
		// 类型图片
		NSString* url = [NSString stringWithFormat:@"%@%@.jpg",
			FKSHOP_IMAGES_ARTICLETYPE, articleType.code];
		UIImage* image = [FKNetworkingUtil getImageWithURLPath:url];
		 // 点击的手势处理器，点击时调用cellViewTapped方法
		UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellViewTapped:)];
		// i = 0 放置在列的第一个视图，否则放第二个视图
		if (i == 0) {
			cell.view1.imageView.image = image;
			cell.view1.nameLabel.text = articleType.name;
			// 传递数据
			cell.view1.code = articleType.code;
			cell.view1.name = articleType.name;
			// 为表格行内的控件添加手势处理器之后，表格行的被选中事件将不会被激发
			[cell.view1 addGestureRecognizer:recognizer];  // ①
		}else{
			cell.view2.imageView.image = image;
			cell.view2.nameLabel.text = articleType.name;
			cell.view2.code = articleType.code;
			cell.view2.name = articleType.name;
			[cell.view2 addGestureRecognizer:recognizer];  // ②
		}
	}
	return cell;
}
// 手势点击时的处理方法
- (void) cellViewTapped:(UITapGestureRecognizer *)recognizer{
	// 获得点击的控件
	ArticleTypeView* view = (ArticleTypeView *)recognizer.view;
	// 创建宝贝详情视图
	ArticleViewController* articlelViewController =
		[[ArticleViewController alloc] init];
	// 将点击选中的商品code传递给类型视图控制器
	articlelViewController.code = view.code;
	[self.navigationController pushViewController:articlelViewController
		animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
