//
//  ArticleTypeView.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleTypeView : UIView
// 类型图片
@property (nonatomic,strong) UIImageView *imageView;
// 类型名称
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *name;
// 该View负责显示的物品
@property (nonatomic,weak) Article *article;
@end
