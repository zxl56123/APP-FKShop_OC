//
//  OrderViewController.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "FKUtils.h"
#import "FKNetworkingUtil.h"
#import "OrderViewController.h"
#import "Article.h"
#import "ShopcarTableViewCell.h"
#import "WXApi.h"
#import "NSString+MD5.h"

@interface OrderViewController () <UITableViewDataSource,
	UITextFieldDelegate>
@end

int orderSize = 18;
@implementation OrderViewController{
	NSArray * _shopCar; // 购物车
	double _sumPrice; // 总金额
	NSString * _body;	// 所有商品的汇总信息
	UILabel * _sumPriceLabel;
	UITableView * _tableView;
	UITextField * _tfName; // 输入的购买数量
	UITextView * _tfAddress; // 输入的购买数量
	UIButton* _btnBuy; // 支付按钮
}
- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.titleView = [FKUtils getCustomLaber:@"确认订单"];
	// 对于iPhone 6s plus
	if (GLOBLE_BOUNDS_WIDTH == 414 && GLOBLE_BOUNDS_HEIGHT == 736){
		orderSize = 20;
	// 对于iPhone 6s
	}else if (GLOBLE_BOUNDS_WIDTH == 375 && GLOBLE_BOUNDS_HEIGHT == 667){
		orderSize = 18;
	// 对于iPhone 5s
	}else if (GLOBLE_BOUNDS_WIDTH == 320 && GLOBLE_BOUNDS_HEIGHT == 568){
		orderSize = 16;
	// 对于iPhone 4s
	}else{
		orderSize = 14;
	}
	// 创建并添加显示收件人标签的UILabel控件
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.1,GLOBLE_BOUNDS_HEIGHT * 0.03, 100 , 20)];
	// 设置字体
	nameLabel.font = [UIFont systemFontOfSize:orderSize];
	// 设置居左对齐
	nameLabel.textAlignment = NSTextAlignmentLeft;
	nameLabel.text = @"收件人：";
	[self.view addSubview:nameLabel];
	// 创建并添加显示收件人信息的UITextField控件
	_tfName = [[UITextField alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.35, GLOBLE_BOUNDS_HEIGHT * 0.03,
		GLOBLE_BOUNDS_WIDTH * 0.5 , GLOBLE_BOUNDS_HEIGHT * 0.04)];
	// 设置圆角边框
	_tfName.borderStyle = UITextBorderStyleRoundedRect;
	// 设置return按钮类型
	_tfName.returnKeyType = UIReturnKeyDone;
	// 设置文字居中对齐
	_tfName.textAlignment = NSTextAlignmentCenter;
	_tfName.delegate = self;
	_tfName.font = [UIFont systemFontOfSize:orderSize - 4];
	_tfName.text = @"黄勇";
	// 添加边框和并设置边框颜色
	_tfName.layer.borderWidth = 1;
	_tfName.layer.borderColor = [UIColor grayColor].CGColor;
	[self.view addSubview:_tfName];
	// 创建并添加显示收件地址标签的UILabel控件
	UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake
		(GLOBLE_BOUNDS_WIDTH * 0.1,GLOBLE_BOUNDS_HEIGHT * 0.1, 100, 20)];
	// 设置字体
	addressLabel.font = [UIFont systemFontOfSize:orderSize];
	// 设置居左对齐
	addressLabel.textAlignment = NSTextAlignmentLeft;
	addressLabel.text = @"收件地址：";
	[self.view addSubview:addressLabel];
	// 创建并添加显示收件地址的UITextView控件
	_tfAddress = [[UITextView alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.35, GLOBLE_BOUNDS_HEIGHT * 0.1 - 5,
		GLOBLE_BOUNDS_WIDTH * 0.5, GLOBLE_BOUNDS_WIDTH * 0.12)];
	_tfAddress.font = [UIFont systemFontOfSize:orderSize - 4];
	// 设置默认显示的内容
	_tfAddress.text = @"广州市天河区车陂大岗路沣宏大厦3011";
	//是否可以拖动
	_tfAddress.scrollEnabled = YES;
	//设置是否允许开启滚动
	_tfAddress.scrollEnabled = YES;
	//开启是否显示边界
	_tfAddress.showsHorizontalScrollIndicator = YES;
	//设置超出边界到时候是否有弹簧效果(默认YES)
	_tfAddress.bounces = YES;
	// 添加边框和并设置边框颜色
	_tfAddress.layer.borderWidth = 1;
	_tfAddress.layer.borderColor = [UIColor grayColor].CGColor;
	// 添加到当前view
	[self.view addSubview:_tfAddress];
	// 创建并添加显示“配送方式”标签的UILabel控件
	UILabel *deliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.1,GLOBLE_BOUNDS_HEIGHT * 0.17, 100, 20)];
	// 设置字体
	deliveryLabel.font = [UIFont systemFontOfSize:orderSize];
	// 设置居左对齐
	deliveryLabel.textAlignment = NSTextAlignmentLeft;
	deliveryLabel.text = @"配送方式";
	[self.view addSubview:deliveryLabel];
	// 创建并添加显示配送方式的UILabel控件
	UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.35, GLOBLE_BOUNDS_HEIGHT * 0.17,
		GLOBLE_BOUNDS_WIDTH * 0.60, 20)];
	// 设置字体
	timeLabel.font = [UIFont systemFontOfSize:orderSize];
	// 设置居左对齐
	timeLabel.textAlignment = NSTextAlignmentLeft;
	// 设置内容
	timeLabel.text = @"顺丰快递（24小时发货）";
	// 添加标签
	[self.view addSubview:timeLabel];
	// 创建并添加显示“支付方式”标签的UILabel控件
	UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.1, GLOBLE_BOUNDS_HEIGHT * 0.24, 100, 20)];
	// 设置字体
	payLabel.font = [UIFont systemFontOfSize:orderSize];
	// 设置居左对齐
	payLabel.textAlignment = NSTextAlignmentLeft;
	payLabel.text = @"支付方式";
	[self.view addSubview:payLabel];
	// 创建并添加显示支付方式的UITextField控件
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(
		GLOBLE_BOUNDS_WIDTH * 0.35, GLOBLE_BOUNDS_HEIGHT * 0.23,
		GLOBLE_BOUNDS_WIDTH * 0.3, GLOBLE_BOUNDS_HEIGHT * 0.04)];
	textField.font = [UIFont systemFontOfSize:orderSize - 4];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.text = @"微信支付";
	textField.userInteractionEnabled = NO;
	[self.view addSubview:textField];
	// 创建并添加显示“商品列表”标签的UILabel控件
	UILabel *spLabel = [[UILabel alloc] initWithFrame:CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.1, GLOBLE_BOUNDS_HEIGHT * 0.31, 100, 20)];
	// 设置字体
	spLabel.font = [UIFont systemFontOfSize:orderSize];
	// 设置居左对齐
	spLabel.textAlignment = NSTextAlignmentLeft;
	spLabel.text = @"商品列表";
	[self.view addSubview:spLabel];
	// 创建并添加显示商品列表的UITableView
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
		GLOBLE_BOUNDS_HEIGHT * 0.35, GLOBLE_BOUNDS_WIDTH,
		GLOBLE_BOUNDS_HEIGHT - GLOBLE_BOUNDS_HEIGHT * 0.55)
		style:UITableViewStylePlain];
	// 设置分隔线
	_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	// 设置UITableView隐藏多余的分割线，UITableView没有数据的时候不显示额外的分隔线
	_tableView.tableFooterView = [[UIView alloc] init];
	_tableView.dataSource = self;
	// 设置行高，和自定义列中的视图一致
	_tableView.rowHeight = GLOBLE_BOUNDS_HEIGHT * 0.2;
	[self.view addSubview:_tableView];
	// 创建、并添加显示合计信息的UILabel控件
	_sumPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, GLOBLE_BOUNDS_HEIGHT * 0.81, 250, 30)];
	// 背景颜色
	_sumPriceLabel.backgroundColor = [UIColor clearColor];
	// 设置字体和颜色
	_sumPriceLabel.font = [UIFont systemFontOfSize:orderSize];
	_sumPriceLabel.textColor = [UIColor redColor];
	// 设置居左对齐
	_sumPriceLabel.textAlignment = NSTextAlignmentLeft;
	_sumPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf",_sumPrice];
	[self.view addSubview:_sumPriceLabel];
	// 创建并添加“支付”按钮
	_btnBuy = [UIButton buttonWithType:UIButtonTypeSystem];
	// 设置按钮位置和大小
	_btnBuy.frame = CGRectMake(GLOBLE_BOUNDS_WIDTH * 0.7,
		GLOBLE_BOUNDS_HEIGHT * 0.81, GLOBLE_BOUNDS_WIDTH * 0.25,
		GLOBLE_BOUNDS_HEIGHT * 0.06);
	// 设置背景图片（使用美工提供的按钮图片）
	[_btnBuy setBackgroundImage:[UIImage imageNamed:JIESUANPNG]
		forState:UIControlStateNormal];
	[_btnBuy setBackgroundImage:[UIImage imageNamed:JIESUANNOPNG]
		forState:UIControlStateDisabled];
	[_btnBuy addTarget:self action:@selector(onPay:)
		forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_btnBuy];
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
		initWithTarget:self action:@selector(viewTapped:)]];
}
- (void)viewTapped:(UITapGestureRecognizer*)recognizer{
	[_tfName resignFirstResponder];
	[_tfAddress resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	_sumPrice = 0;
	// 获取购物车数据
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSDictionary * dict = [userDefaults objectForKey:SHOP_CAR];
	_shopCar = dict.allValues;
	_body = @"";
	// 遍历购物车
	for (NSData *data in _shopCar) {
		// 恢复Article对象
		Article* article = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		// 合并所有商品的名称
		if ([ _body isEqualToString:@""]) {
			_body = article.title;
		}else{
			_body = [NSString stringWithFormat:@"%@,%@", _body, article.title];
		}
		double price = article.price.doubleValue; // 获取商品的价格
		int buyNum = article.buyNum.intValue; // 获取商品的购买数量
		_sumPrice += price * buyNum;
	}
	// 有商品时，支付按钮才可用
	_btnBuy.enabled = _sumPrice > 0;
	_sumPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf", _sumPrice];
	[_tableView reloadData];
}

// 返回指定分区内包含的表格行的数量（_shopCar内有几条数据，就包含几个表格行）
- (NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section{
	return _shopCar.count;
}
// 返回表格内每个单元格的控件
- (UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	// 为表格行定义一个静态字符串作为可重用标识符
	static NSString* cellID = @"cellID";
	ShopCarTableViewCell *cell = [tableView
		dequeueReusableCellWithIdentifier:cellID];
	// 如果从“可重用单元格队列”中取出的UITableViewCell为空，则创建一个
	if (!cell) {
		cell = [[ShopCarTableViewCell alloc] initWithStyle:
			UITableViewCellStyleDefault reuseIdentifier:cellID];
	}
	// 物品类型对象
	NSData* data = _shopCar[indexPath.row];
	Article* article = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	// 网络读取图片数据
	NSString* imageURL = [NSString stringWithFormat:@"%@%@",
		FKSHOP_IMAGES_ARTICLE, article.image];
	UIImage* image = [FKNetworkingUtil getImageWithURLPath:imageURL];
	// 商品图片
	cell.articleImageView.image = image;
	// 商品描述
	cell.titleLabel.text = article.title;
	// 供应商信息
	cell.supplierLabel.text = article.supplier;
	// 商品价格
	cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2lf",
		article.price.doubleValue];
	// 购买数量
	cell.buyNumLabel.text = [NSString stringWithFormat:@"×%@",
		article.buyNum];
	return cell;
}
// “支付”按钮的事件处理方法
- (void)onPay:(id) sender {
	// 提交数据到后台（金额，商品描述，终端IP）
	NSString* ipAddress = [FKUtils getCurrentIPAddress];
	NSLog(@"body = %@" , _body);
	NSLog(@"sumPrice = %g" , _sumPrice);
	NSLog(@"ipAddress = %@" , ipAddress);
	NSLog(@"========开始支付流程========");
	// 定义后台应用中统一下单的URL字符串
	NSString* urlString = [NSString stringWithFormat:@"%@/app/pay.action",
						   CONTEXT_ROOT];
	// 创建发送请求的的NSMutableURLRequest对象
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
									[NSURL URLWithString:urlString]];
	request.HTTPMethod = @"POST";
	NSString* parameter = [NSString stringWithFormat:@"bodyValue=%@&total_fee=%g&spbill_create_ip=%@", _body, _sumPrice, ipAddress];
	// 为NSMutableURLRequest指定请求参数
	request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
	// ①、向后台应用发送统一下单的POST请求
	NSURLSessionDataTask* task = [[NSURLSession sharedSession]
		dataTaskWithRequest:request
		completionHandler: ^(NSData *data, NSURLResponse *response,
		NSError *error){
		if (data != nil) {
			// 使用JSON解析来解析服务器响应
			NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data
				options:NSJSONReadingMutableLeaves error:nil];
			NSLog(@"请求返回字典:%@" , dict);
			if (dict != nil) {
				NSString* retcode = dict[@"retcode"];
				if (retcode.intValue == 0) {
					NSString* stamp = dict[@"timestamp"];
					// ②、发起微信支付
					PayReq* req = [[PayReq alloc] init];
					req.partnerId = dict[@"partnerid"];
					req.prepayId = dict[@"prepayid"];
					req.nonceStr = dict[@"noncestr"];
					req.timeStamp = stamp.intValue;
					req.package = dict[@"package"];
					/********生成签名（详见微信文档的签名生成算法）************************/
					NSString* stringA = [NSString stringWithFormat:@"appid=%@&noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%@",[dict objectForKey:@"appid"], req.nonceStr, req.package, req.partnerId, req.prepayId, stamp];
					// 设置API密钥字符串
					NSString* stringSignTemp = [NSString stringWithFormat:@"%@&key=fkjava36750064247ec02edce69f6a2d",stringA];
					// 对stringSignTemp字符串进行MD5加密后作为req的签名
					req.sign = [stringSignTemp md5].uppercaseString;
					// 发送支付请求
					[WXApi sendReq:req];
				}
			}
		}
	}];
	[task resume];
}

// 用户支付成功后的处理方法
- (void)onPaySuccess{
	_btnBuy.enabled = NO; // 支付完成，取消支付按钮的可用状态
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
	// 清空购物车
	[userDefaults setObject:nil forKey:SHOP_CAR];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}
@end
