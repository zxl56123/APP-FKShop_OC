//
//  ShopCarTableViewCell.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ShopCarTableViewCell : UITableViewCell
// 显示商品图片的UIImageView控件
@property(retain,nonatomic) UIImageView *articleImageView;
// 显示商品名称的UILabel控件
@property(retain,nonatomic) UILabel *titleLabel;
// 显示供应商的UILabel控件
@property(retain,nonatomic) UILabel *supplierLabel;
// 显示商品价格UILabel控件
@property(retain,nonatomic) UILabel *priceLabel;
// 显示购买数量的UILabel控件
@property(retain,nonatomic) UILabel *buyNumLabel;

@end
