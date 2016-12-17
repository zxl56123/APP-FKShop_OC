//
//  ArticleTableViewCell.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell
// 显示物品图片的UIImageView控件
@property (nonatomic,strong) UIImageView *articleImageView;
// 显示物品名称的UILabel控件
@property (nonatomic,strong) UILabel *titleLabel;
// 显示物品供应商的UILabel控件
@property (nonatomic,strong) UILabel *supplierLabel;
// 显示物品价格的UILabel控件
@property (nonatomic,strong) UILabel *priceLabel;
@end
