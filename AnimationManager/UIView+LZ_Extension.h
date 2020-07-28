//
//  UIView+LZ_Extension.h
//  MTOWallert
//
//  Created by lvzhao on 2019/4/20.
//  Copyright © 2019 吕VV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LZ_Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;


/** 圆角半径 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/** 边线宽度 */
@property (nonatomic, assign) IBInspectable CGFloat bWidth;
/** 边线颜色 */
@property (nonatomic, strong) IBInspectable UIColor *bColor;
/** 是否选中 */
@property (nonatomic, assign) IBInspectable BOOL isChecked;
/** 选中背景色 */
@property (nonatomic, strong) IBInspectable UIColor *sbgColor;
/** 未选中背景色 */
@property (nonatomic, strong) IBInspectable UIColor *nbgColor;






/** 创建view */
+ (UIView *)lz_createViewWithFrame:(CGRect)frame color:(UIColor *)color;

/** 找到自己的所属viewController */
- (UIViewController *)lz_belongsViewController;

/** 找到当前显示的viewController */
- (UIViewController *)lz_currentViewController;

/** 添加手势点击事件 */
- (void)lz_addGestureAction:(id)target selector:(SEL)selector;

/**
 View截图
 
 @return 截图Image
 */
- (UIImage *)lz_screenshot;
/**
 View截图(指定范围截图)
 
 @param frame 指定范围
 @return 截图Image
 */
- (UIImage *)lz_screenshotInFrame:(CGRect)frame;
/**
 ScrollView截图
 
 @param contentOffset 偏移量
 @return 截图Image
 */
- (UIImage *)lz_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;


/**
 Convert 切园View
 @param direction       方向
 @param cornerRadiu     半径
 */
- (void)clipRectCorner:(UIRectCorner)direction cornerRadius:(CGFloat)cornerRadiu;

@end

NS_ASSUME_NONNULL_END
