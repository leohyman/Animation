//
//  UIView+LZ_Extension.m
//  MTOWallert
//
//  Created by lvzhao on 2019/4/20.
//  Copyright © 2019 吕VV. All rights reserved.
//

#import "UIView+LZ_Extension.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation UIView (LZ_Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}
- (void)setBColor:(UIColor *)bColor {
    self.layer.borderColor = bColor.CGColor;
}
- (UIColor *)bColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBWidth:(CGFloat)bWidth {
    self.layer.borderWidth = bWidth;
}
- (CGFloat)bWidth {
    return self.layer.borderWidth;
}
- (void)setSbgColor:(UIColor *)sbgColor {
    objc_setAssociatedObject(self, @selector(sbgColor), sbgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)sbgColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNbgColor:(UIColor *)nbgColor {
    objc_setAssociatedObject(self, @selector(nbgColor), nbgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)nbgColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setIsChecked:(BOOL)isChecked {
    NSNumber *number = [NSNumber numberWithBool:isChecked];
    objc_setAssociatedObject(self, @selector(isChecked), number, OBJC_ASSOCIATION_ASSIGN);
    
    self.backgroundColor = isChecked ? self.sbgColor : self.nbgColor;
}
- (BOOL)isChecked {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}




+ (UIView *)lz_createViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor  = color;
    
    return view;
}

- (UIViewController *)lz_belongsViewController {
    
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (UIViewController *)lz_currentViewController {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    return [self lz_getCurrentViewController:appDelegate.window.rootViewController];
}

//递归查找
- (UIViewController *)lz_getCurrentViewController:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        
        UINavigationController *nav = ((UITabBarController *)controller).selectedViewController;
        return [nav.viewControllers lastObject];
    }
    else if ([controller isKindOfClass:[UINavigationController class]]) {
        
        return [((UINavigationController *)controller).viewControllers lastObject];
    }
    else if ([controller isKindOfClass:[UIViewController class]]) {
        
        return controller;
    }
    else {
        
        return nil;
    }
}

- (void)lz_addGestureAction:(id)target selector:(SEL)selector {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (UIImage*)lz_screenshot {
    
    //https://blog.csdn.net/u011619283/article/details/78658613
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = self.frame;
    [self drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return snapshotImage;
    
    
    
    
    
//    UIGraphicsBeginImageContext(self.bounds.size);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    // helps w/ our colors when blurring
//    // feel free to adjust jpeg quality (lower = higher perf)
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
//    image = [UIImage imageWithData:imageData];
//
//    return image;
}
- (UIImage*)lz_screenshotInFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}
- (UIImage *)lz_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    UIGraphicsBeginImageContext(self.bounds.size);
    //need to translate the context down to the current visible portion of the scrollview
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (void)clipRectCorner:(UIRectCorner)direction cornerRadius:(CGFloat)cornerRadius {
    [self layoutIfNeeded];
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath * maskPath =[UIBezierPath  bezierPathWithRoundedRect:self
                              .bounds byRoundingCorners:direction cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
}
@end
