//
//  LineView.m
//  FKShop_OC
//
//  Created by yeeku on 16/6/7.
//  Copyright © 2016年 org.crazyit. All rights reserved.
//

#import "Common.h"
#import "LineView.h"

@implementation LineView
// 重写drawRect:方法，绘制自定义内容
- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	// 线宽
	CGContextSetLineWidth(ctx, 2);
	// 设置画笔的颜色
	CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
	// 定义绘制直线的两个端点	
	CGPoint points[] = {CGPointMake(0, 10),
		CGPointMake(GLOBLE_BOUNDS_WIDTH - 20, 10)};
	// 画直线
	CGContextStrokeLineSegments(ctx, points, 2);
}
// 初始化方法
- (id)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		// 设置该控件背景色为白色
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}
@end
