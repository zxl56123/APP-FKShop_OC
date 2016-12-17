//
//  DetailViewController.h
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

// 显示物品详情的视图控制器
@interface DetailViewController : UIViewController

@property (nonatomic,strong) Article *article;

@end
