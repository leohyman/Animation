//
//  Animation.m
//  AnimationManager
//
//  Created by lvzhao on 2020/7/27.
//  Copyright © 2020 吕VV. All rights reserved.
//

#import "Animation.h"
#import "AnimationManager.h"
#import "UIView+LZ_Extension.h"






@interface Animation ()<CAAnimationDelegate>

//动画图片
@property (nonatomic,strong) UIImageView *animationImageView;

///动画展示所在的View，_animationImageView的superView
@property (nonatomic,strong) UIView *contentView;

///动画的左右运动
@property (nonatomic,assign) AnimationDirectiont directiont;

///动画类型
@property (nonatomic,assign) AnimationType animationType;

///抛物线起点
@property (nonatomic,assign) CGPoint parabolaStartPoint;
///抛物线终点
@property (nonatomic,assign) CGPoint parabolaEndPoint;
///抛物线顶点坐标
@property (nonatomic,assign) CGPoint parabolaApexPoint;

///动画结束的时候的坐标
@property (nonatomic,assign) CGRect animationEndFrame;


///动画完成
@property (nonatomic,copy) AnimationFinish animationBlock;
@end

@implementation Animation
- (void)dealloc{
    NSLog(@"动画结束, 释放---Animation");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - 大赞坠落反弹动画
- (void)showBigPraise:(UIView *)contentView block:(AnimationFinish)block{

    self.contentView = contentView;
    self.animationBlock = block;
    
    UIImage *image = [UIImage imageNamed:@"big_praise"];
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake((contentView.width - image.size.width)/2.0, (contentView.height - image.size.height)/2.0, image.size.width, image.size.height)];
    animationImageView.image = image;
    self.animationImageView = animationImageView;
    [contentView addSubview:animationImageView];
    self.animationEndFrame = self.animationImageView.frame;

    //动画
    CAKeyframeAnimation * praiseanimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef animationPath = CGPathCreateMutable();//动画路径
    CGPathMoveToPoint(animationPath, NULL, CGRectGetMidX(contentView.frame), -(image.size.width / 2));
    CGPathAddLineToPoint(animationPath, NULL, CGRectGetMidX(contentView.frame), CGRectGetHeight(contentView.frame) - (image.size.width / 2));
    CGPathAddLineToPoint(animationPath, NULL, CGRectGetMidX(contentView.frame), CGRectGetHeight(contentView.frame) - (CGRectGetHeight(contentView.frame)) * 0.5);
    praiseanimation.delegate = self;
    praiseanimation.path = animationPath;
    praiseanimation.duration = 0.6;
    [animationImageView.layer addAnimation:praiseanimation forKey:@"move"];
    
    CFRelease(animationPath);
}


#pragma mark - 气球升空效果
- (void)showBalloonStartPoint:(CGPoint)startPoint contentView:(UIView *)contentView block:(AnimationFinish)block{

    self.contentView = contentView;
    self.animationBlock = block;
    
    self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80.f, 80.f)];
    self.animationImageView.backgroundColor = [UIColor clearColor];
    self.animationImageView.image = [UIImage imageNamed:@"party10"];
    [contentView addSubview:self.animationImageView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef animationPath = CGPathCreateMutable();
    CGPathMoveToPoint(animationPath, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(animationPath, NULL, startPoint.x, CGRectGetHeight(self.contentView.frame)/2.0);
    animation.path = animationPath;
    animation.duration = 0.5;
    animation.delegate = self;
    [_animationImageView.layer addAnimation:animation forKey:@"move"];
    
    self.animationEndFrame = CGRectMake(startPoint.x, CGRectGetHeight(self.contentView.frame)/2.0, 80, 80);
    
    CFRelease(animationPath);
}


#pragma mark - 抛物线动画
- (void)showParabola:(CGRect)frame image:(UIImage *)image showView:(UIView *)contentView type:(AnimationType)animationType{

    self.contentView = contentView;
    self.parabolaStartPoint = frame.origin;
    self.parabolaEndPoint = frame.origin;;
    
    
    BOOL iaAddQuadCurvrPoint = YES;//判断是否要增加抛物线路劲
    CGFloat distance = 0;
    NSInteger midAutumnCount = 0; //中秋表情使用

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(contentView.width, contentView.height, image.size.width,  image.size.height)];
    imageView.image = image;
    self.animationImageView = imageView;
    [self.contentView addSubview:imageView];
    self.directiont = arc4random() % 2;//随机选择抛物线运动方向

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef animationPath = CGPathCreateMutable();
    CGPathMoveToPoint(animationPath, NULL, frame.origin.x , frame.origin.y);


    do {//该循环是用于判断弹跳几次的
        iaAddQuadCurvrPoint = [self calculateParabolaParameter:animationType];
        CGPathAddQuadCurveToPoint(animationPath, NULL, self.parabolaApexPoint.x, self.parabolaApexPoint.y,self.parabolaEndPoint.x, self.parabolaEndPoint.y);
        distance += CGRectGetHeight(self.contentView.frame) - self.parabolaApexPoint.y;
    } while (iaAddQuadCurvrPoint);

    animation.delegate = self;
    animation.path = animationPath;
    animation.duration = distance * 1.8f / 500 * 1.5 / 3;
    [imageView.layer addAnimation:animation forKey:@"move"];

    CFRelease(animationPath);
}


#pragma mark - 该方法用于计算抛物线的各项参数
- (BOOL)calculateParabolaParameter:(AnimationType)type
{
      NSInteger parabolaWidth;//用于决定抛物线的开口大小
       NSInteger parabolaHeight = 0;//用于决定抛物线高度
       
       parabolaWidth = arc4random() % (NSInteger)(CGRectGetWidth(self.contentView.frame) / 2) + 40;
       switch (type)
       {
           case AnimationTypePraise://大赞一个
                parabolaHeight = arc4random() % (NSInteger)(CGRectGetHeight(self.contentView.frame) * 0.7) + (CGRectGetHeight(self.contentView.frame) * 0.7);
               break;
               
           case AnimationTypeParty:
               parabolaHeight = arc4random() % (NSInteger)(CGRectGetHeight(self.contentView.frame) * 0.4) + (CGRectGetHeight(self.contentView.frame) * 0.3);
               break;
           default:
               break;
       }
       
       
       
       switch (self.directiont)
       {
           case AnimationDirectiontLeft://抛物线向左边运动
           {
               self.parabolaApexPoint = CGPointMake(self.parabolaEndPoint.x - (parabolaWidth / 2), CGRectGetHeight(self.contentView.frame) - parabolaHeight);
                
               CGPoint endPoint = self.parabolaEndPoint;
               endPoint.x -= parabolaWidth;
               endPoint.y = CGRectGetHeight(self.contentView.frame);
               self.parabolaEndPoint = endPoint;
               if (self.parabolaEndPoint.x >= 0) return YES;
           }
               break;
               
           case AnimationDirectiontRight://抛物线向右边运动
           {
               self.parabolaApexPoint = CGPointMake(self.parabolaEndPoint.x + (parabolaWidth / 2), CGRectGetHeight(self.contentView.frame) - parabolaHeight);
               CGPoint endPoint = self.parabolaEndPoint;
               endPoint.x += parabolaWidth;
               endPoint.y =  CGRectGetHeight(self.contentView.frame) - (CGRectGetHeight(self.animationImageView.frame) / 3);
               self.parabolaEndPoint = endPoint;
               if (self.parabolaEndPoint.x <= CGRectGetWidth(self.contentView.frame)) return YES;
           }
               break;
               
           default:
               break;
       }
       return NO;
}




#pragma mark - 动画停止
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
   
    //动画结束
    [self.animationImageView removeFromSuperview];
    self.animationImageView.hidden = YES;
    if(self.animationBlock){
        self.animationBlock(self.animationEndFrame);
    }
}
@end
