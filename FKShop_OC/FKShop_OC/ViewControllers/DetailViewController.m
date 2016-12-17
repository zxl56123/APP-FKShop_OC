//
//  DetailViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "FKUtils.h"
#import "FKNetworkingUtil.h"
#import "DetailViewController.h"
#import "MainViewController.h"
#import "OrderViewController.h"
#import "LineView.h"


@interface DetailViewController ()
@end

@implementation DetailViewController {
	UITextField * _textField; // 输入的购买数量的文本框
	NSMutableDictionary *_shopCar; // 购物车
	UIImageView * _imageView;
	UILabel * _titleLabel;
	UILabel * _priceLabel;
	UILabel * _descriptionLabel;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	int detailSize = 12;
	// 对于iPhone 6s Plus
	if (GLOBLE_BOUNDS_WIDTH == 414 && GLOBLE_BOUNDS_HEIGHT == 736){
		detailSize = 17;
	// 对于iPhone 6s
	}else if (GLOBLE_BOUNDS_WIDTH == 375 && GLOBLE_BOUNDS_HEIGHT == 667) {
		detailSize = 15;
	// 对于iPhone 5s
	}else if (GLOBLE_BOUNDS_WIDTH == 320 && GLOBLE_BOUNDS_HEIGHT == 568){
	// 对于iPhone4s
		detailSize = 13;
	}else{
		detailSize = 12;
	}
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.titleView = [FKUtils getCustomLaber:@"宝贝详情"];
	// 创建、并添加显示商品图片的UIImageView控件
	_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, GLOBLE_BOUNDS_WIDTH - 100, GLOBLE_BOUNDS_HEIGHT * 0.4)];
	_imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:_imageView];
	// 创建、并添加显示商品描述的UILabel控件
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 ,
		GLOBLE_BOUNDS_HEIGHT * 0.4, GLOBLE_BOUNDS_WIDTH -20,
		GLOBLE_BOUNDS_HEIGHT *0.11)];
	// 设置背景色
	_titleLabel.backgroundColor = [UIColor clearColor];
	// 设置字体
	_titleLabel.font = [UIFont systemFontOfSize:detailSize];
	// 设置居左对齐
	_titleLabel.textAlignment = NSTextAlignmentLeft;
	// 设置没有行数限制
	_titleLabel.numberOfLines = 0;
	[self.view addSubview:_titleLabel];
	// 创建、并添加显示商品价格的UILabel控件
	_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,
		GLOBLE_BOUNDS_HEIGHT * 0.4 + _titleLabel.frame.size.height ,
		GLOBLE_BOUNDS_WIDTH -20 , GLOBLE_BOUNDS_HEIGHT *0.03)];
	// 设置背景色
	_priceLabel.backgroundColor = [UIColor clearColor];
	// 设置字体和颜色
	_priceLabel.font = [UIFont systemFontOfSize:detailSize];
	_priceLabel.textColor = [UIColor redColor];
	_priceLabel.textAlignment = NSTextAlignmentLeft;
	[self.view addSubview:_priceLabel];
	// 创建、并添加显示销量信息的UILabel控件
	UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
		GLOBLE_BOUNDS_HEIGHT * 0.4 + _titleLabel.frame.size.height
		+ _priceLabel.frame.size.height, GLOBLE_BOUNDS_WIDTH - 20,
		GLOBLE_BOUNDS_HEIGHT * 0.02)];
	// 设置背景色
	contentLabel.backgroundColor = [UIColor clearColor];
	// 设置字体和颜色
	contentLabel.font = [UIFont systemFontOfSize:detailSize];
	contentLabel.textColor = [UIColor grayColor];
	contentLabel.textAlignment = NSTextAlignmentLeft;
	contentLabel.text = @"卖家包邮   月销5000笔   广州发货";
	[self.view addSubview:contentLabel];
	// 添加线条分隔条
	LineView *line = [[LineView alloc] initWithFrame:CGRectMake(10, GLOBLE_BOUNDS_HEIGHT * 0.4 + _titleLabel.frame.size.height + _priceLabel.frame.size.height + contentLabel.frame.size.height, GLOBLE_BOUNDS_WIDTH - 20, GLOBLE_BOUNDS_HEIGHT * 0.04)];
	[self.view addSubview:line];
	// 创建、并添加显示商品评价的UILabel控件
	UILabel *bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
		GLOBLE_BOUNDS_HEIGHT * 0.4 + _titleLabel.frame.size.height
		+ _priceLabel.frame.size.height + contentLabel.frame.size.height
		+ line.frame.size.height, GLOBLE_BOUNDS_WIDTH - 20,
		GLOBLE_BOUNDS_HEIGHT * 0.02)];
	// 设置背景色
	bodyLabel.backgroundColor = [UIColor clearColor];
	// 设置字体
	bodyLabel.font = [UIFont systemFontOfSize:detailSize];
	bodyLabel.textAlignment = NSTextAlignmentLeft;
	bodyLabel.text = @"宝贝评价";
	[self.view addSubview:bodyLabel];
	// 创建、并添加显示评价内容的UILabel控件
	_descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,GLOBLE_BOUNDS_HEIGHT * 0.4 + _titleLabel.frame.size.height + _priceLabel.frame.size.height + contentLabel.frame.size.height + line.frame.size.height + bodyLabel.frame.size.height, GLOBLE_BOUNDS_WIDTH -20 , GLOBLE_BOUNDS_HEIGHT *0.15)];
	// 设置背景色
	_descriptionLabel.backgroundColor = [UIColor clearColor];
	// 设置字体
	_descriptionLabel.font = [UIFont systemFontOfSize:detailSize];
	_descriptionLabel.numberOfLines = 0;
	_descriptionLabel.textAlignment = NSTextAlignmentLeft;
	[self.view addSubview:_descriptionLabel];
	// 创建、并添加显示“数量：”的UILabel控件
	UILabel *buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
		GLOBLE_BOUNDS_HEIGHT * 0.80, GLOBLE_BOUNDS_WIDTH * 0.25 ,
		GLOBLE_BOUNDS_HEIGHT * 0.04)];
	// 设置背景色
	buyNumLabel.backgroundColor = [UIColor clearColor];
	// 设置字体
	buyNumLabel.font = [UIFont systemFontOfSize:18];
	buyNumLabel.textAlignment = NSTextAlignmentLeft;
	buyNumLabel.text = @"数量：";
	[self.view addSubview:buyNumLabel];
	// 创建、并添加输入购买数量的UITextField控件
	_textField = [[UITextField alloc] initWithFrame:CGRectMake(75,
		GLOBLE_BOUNDS_HEIGHT * 0.80, GLOBLE_BOUNDS_WIDTH * 0.2 ,
		GLOBLE_BOUNDS_HEIGHT * 0.04)];
	// 提示信息
	_textField.text = @"1";
	// 设置圆角边框
	_textField.borderStyle = UITextBorderStyleRoundedRect;
	_textField.keyboardType = UIKeyboardTypeNumberPad;
	_textField.textAlignment = NSTextAlignmentCenter;
	// 添加边框和设置边框颜色
	_textField.layer.borderWidth = 1;
	_textField.layer.borderColor = [UIColor grayColor].CGColor;
	[self.view addSubview:_textField];
	// 创建并添加“添加到购物车“的按钮
	UIButton* btnCar = [UIButton buttonWithType:UIButtonTypeSystem];
	// 设置大小和位置
	btnCar.frame = CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.44,
		GLOBLE_BOUNDS_HEIGHT * 0.79, GLOBLE_BOUNDS_WIDTH * 0.24,
		GLOBLE_BOUNDS_HEIGHT * 0.06);
	// 获取按钮的图片（使用美工提供的按钮图片）
	UIImage* putimage = [UIImage imageNamed:PUTINPNG];
	[btnCar setBackgroundImage:putimage
		forState:UIControlStateNormal];
	[self.view addSubview:btnCar];
	// 创建并添加“立即购买”的按钮
	UIButton* btnBuy = [UIButton buttonWithType:UIButtonTypeSystem];
	// 设置大小和位置
	btnBuy.frame = CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.73,
		GLOBLE_BOUNDS_HEIGHT * 0.79, GLOBLE_BOUNDS_WIDTH * 0.24,
		GLOBLE_BOUNDS_HEIGHT * 0.06);
	// 获取图片名称
	UIImage* buyImage = [UIImage imageNamed:BUYNOWJPG];
	// 设置图片背景（使用美工提供的按钮图片）
	[btnBuy setBackgroundImage:buyImage
		forState:UIControlStateNormal];
	[self.view addSubview:btnBuy];
	// 为两个按钮添加事件处理方法
	[btnCar addTarget:self action:@selector(onAddShopcar:) forControlEvents:UIControlEventTouchUpInside];
	[btnBuy addTarget:self action:@selector(onBuy:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
		initWithTarget:self action:@selector(viewTapped:)]];
}
- (void)viewTapped:(UITapGestureRecognizer*)recognizer{
	[_textField resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	// 网络读取图片数据
	NSString *imageURL = [NSString stringWithFormat:@"%@%@",
		FKSHOP_IMAGES_ARTICLE,self.article.image];
	UIImage* image = [FKNetworkingUtil getImageWithURLPath:imageURL];
	// 设置图片控件显示商品的图片
	_imageView.image = image;
	// 设置显示商品的标题
	_titleLabel.text = self.article.title;
	// 设置显示商品的价格
	_priceLabel.text = [NSString stringWithFormat:@"￥%.2lf",
		self.article.price.doubleValue];
	// 设置显示商品的描述
	_descriptionLabel.text = self.article.descriptions;
}

// 加入购物车的响应事件
- (void)onAddShopcar:(id) sender {
	// 1.从NSUserDefaults获得购物车NSMutableArray
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary * dict = [userDefaults valueForKey:SHOP_CAR];
	// 如果购物车为空则创建一个NSMutableDictionary对象
	if (dict == nil) {
		dict = [[NSMutableDictionary alloc] init];
	}
	_shopCar = [NSMutableDictionary dictionaryWithDictionary:dict];
	// 判断是否重复购买
	NSData* oldData = _shopCar[self.article.id];
	if (oldData) {
		Article* oldArticle = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
		NSInteger oldBuyNum = [oldArticle.buyNum integerValue]; // 之前的购买数量
		NSInteger currBuyNum = [_textField.text integerValue]; // 当前的购买数量
		self.article.buyNum = [NSString stringWithFormat:@"%ld", oldBuyNum + currBuyNum];
	}else{
		// 获得购买的数量
		self.article.buyNum = _textField.text;
	}
	// 2.需要使用NSKeyedArchiver把数据归档为NSData对象，然后把NSData存储到购物车中
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.article];
	_shopCar[self.article.id] = data;
	// 3.将购物车保存到NSUserDefaults对象
	[userDefaults setObject:_shopCar forKey:SHOP_CAR];
	// 4. 提示框
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:
		@"提示" message: @"商品添加成功!"
		preferredStyle: UIAlertControllerStyleAlert];
	// 创建、并添加一个UIAlertAction，该Action有关联的处理行为
	UIAlertAction* action = [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDestructive handler: ^(UIAlertAction * action) {
		// 跳转到购物车视图
		// 获得navigationController的所有子UIViewController
		NSArray* viewControllers = self.navigationController.viewControllers;
		for (UIViewController *viewController in viewControllers) {
			// 判断当前的UIViewController是不是MainViewController类型
			if ([viewController isKindOfClass:[MainViewController class]]) {
				// 找到上层的MainViewController
				MainViewController* mainViewController = (MainViewController *)viewController;
				// 设置选项卡显示第二个item既购物车视图
				mainViewController.selectedIndex = 1;
				break;
			}
		}
		// pop到RootViewController即MainViewController
	   [self.navigationController popToRootViewControllerAnimated:YES];
	}];
	[alert addAction:action];
	// 将action对应的按钮设置为“高亮”按钮
	alert.preferredAction = action;
	// 显示UIAlertController
	[self presentViewController:alert animated: YES completion: nil];
}
// 处理购买事件
- (void)onBuy:(id) sender {
	NSInteger currBuyNum = _textField.text.integerValue; // 当前的购买数量
	self.article.buyNum = [NSString stringWithFormat:@"%ld", currBuyNum];
	// 生成新的购物车
	NSMutableDictionary* shopCar = [NSMutableDictionary dictionary];
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.article];
	shopCar[self.article.id] = data;
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
	// 将购物车保存到NSUserDefaults对象
	[userDefaults setObject:shopCar forKey:SHOP_CAR];
	// 创建订单详情视图
	OrderViewController* orderViewController = [[OrderViewController alloc] init];
	// 显示新的视图控制器
	[self.navigationController pushViewController:orderViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
