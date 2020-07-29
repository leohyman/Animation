//
//  AnimationManager.h
//  AnimationManager
//
//  Created by lvzhao on 2020/7/27.
//  Copyright © 2020 吕VV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


///抛物线的类型
typedef NS_ENUM(NSInteger, AnimationType)
{
    /// 大赞一个
    AnimationTypePraise,
    /// 聚餐
    AnimationTypeParty,
    ///祝贺
    AnimationTypeCongratulate,
    
};

///抛物线动画的运动方向
typedef NS_ENUM(NSInteger, AnimationDirectiont){
    ///抛物线向左边运动
    AnimationDirectiontLeft,
    ///抛物线向右边运动
    AnimationDirectiontRight
};


NS_ASSUME_NONNULL_BEGIN

@interface AnimationManager : NSObject

/** 单例*/
+ (instancetype)shareManager;

/*展示动画**/
- (void)showAnimation:(UIView *)contentView animation:(AnimationType)type;

@end

NS_ASSUME_NONNULL_END
