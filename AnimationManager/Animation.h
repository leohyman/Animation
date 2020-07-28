//
//  Animation.h
//  AnimationManager
//
//  Created by lvzhao on 2020/7/27.
//  Copyright © 2020 吕VV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^AnimationFinish)(CGRect rect);


NS_ASSUME_NONNULL_BEGIN

@interface Animation : NSObject



#pragma mark - 大赞坠落反弹动画
- (void)showBigPraise:(UIView *)contentView block:(AnimationFinish)block;

- (void)showParabola:(CGRect)frame image:(UIImage *)image showView:(UIView *)contentView;

@end

NS_ASSUME_NONNULL_END
