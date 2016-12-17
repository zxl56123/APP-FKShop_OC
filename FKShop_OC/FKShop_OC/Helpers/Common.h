//
//  Common.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//


#ifndef FKShop_Common_h
#define FKShop_Common_h

// 全局bounds
#define GLOBLE_BOUNDS [UIScreen mainScreen].bounds
// 全局宽度
#define GLOBLE_BOUNDS_WIDTH [UIScreen mainScreen].bounds.size.width
// 全局高度
#define GLOBLE_BOUNDS_HEIGHT [UIScreen mainScreen].bounds.size.height
// 获取视图的宽度
#define GET_VIEW_WIDTH(view) (view.frame.size.width)
// 获取视图的高度
#define GET_VIEW_HEIGHT(view) (view.frame.size.height)
// 外网服务器地址为: "http://115.29.28.226:80/fk_ec/"
#define CONTEXT_ROOT @"http://115.29.28.226:80/fk_ec/"
//#define CONTEXT_ROOT @"http://192.168.1.104:8888/fk_ec/"
// 服务器图片路径
#define FKSHOP_IMAGES CONTEXT_ROOT@"images/"
#define FKSHOP_IMAGES_ARTICLE CONTEXT_ROOT@"images/article/"
#define FKSHOP_IMAGES_ARTICLETYPE CONTEXT_ROOT@"articleType/"
// UITabBarItem图标路径
#define HOMENMPNG @"guide_home_nm.png"
#define HOMEONPNG @"guide_home_on.png"
#define TYPENMPNG @"guide_tfaccount_nm.png"
#define TYPEONPNG @"guide_tfaccount_on.png"
#define SHOPCARNMPNG @"guide_cart_nm.png"
#define SHOPCARONPNG @"guide_cart_on.png"
#define ACCOUNTRNMPNG @"guide_account_nm.png"
#define ACCOUNTONPNG @"guide_account_on.png"
// 按钮图片
#define PUTINPNG @"put_in.png"
#define SUBMITPNG @"submit.png"
#define BUYNOWJPG @"buy_now.png"
#define JIESUANPNG @"pay_now.png"
#define JIESUANNOPNG @"pay_now_no.png"
#define MENUTOPLEFTPNG @"menu_top_left.png"
#define MENUTOPRIGHTPNG @"menu_top_right.png"
#define EDITPNG @"bg_menu_edit.png"

// 请求获取json数据路径
#define ARTICLETYPE_ACTION CONTEXT_ROOT@"android/articleType.action"
#define ARTICLE_ACTION CONTEXT_ROOT@"android/article.action?code="

// 定义购物车的key
#define SHOP_CAR @"shopCar"
#endif
