//
//  AnimationManager.m
//  AnimationManager
//
//  Created by lvzhao on 2020/7/27.
//  Copyright © 2020 吕VV. All rights reserved.
//

#import "AnimationManager.h"
#import "UIView+LZ_Extension.h"
#import "Animation.h"





@interface AnimationManager ()

@property (nonatomic,strong) UIView *contentView;

@end

@implementation AnimationManager

static AnimationManager *animationManager = nil;

/** 单例 */
+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animationManager = [[AnimationManager alloc] init];
    });
    return animationManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)showAnimation:(UIView *)contentView animation:(AnimationType)type{
    
    self.contentView = contentView;
    //展示动画
    switch (type) {
        case AnimationTypePraise:
        {
            [self showPraiseAnimation];
        }
            break;
            
        default:
            break;
    }
    

    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
}

//展示大赞动画
- (void)showPraiseAnimation{
    
    Animation *praiseAnimation = [[Animation alloc] init];
    [praiseAnimation showBigPraise:self.contentView block:^(CGRect rect) {
        //大赞往下落的动画效果, 结束. 开始抛物线动画
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++){
            NSString *imageName = [NSString stringWithFormat:@"praise%d",i+1];
            [imageArray addObject:[UIImage imageNamed:imageName]];
        }

        for (int i = 0; i < 20; i++){
            UIImage *image = imageArray[arc4random() % imageArray.count];
            //随机X的坐标
            CGFloat randX = arc4random() % (NSInteger)(rect.origin.x) + rect.size.width;
            
            //随机Y的坐标
            CGFloat randY = arc4random() % (NSInteger)(rect.origin.y) + rect.size.height;
            
            NSLog(@"rect == %@",NSStringFromCGRect(rect));

            NSLog(@"x == %f",randX);
            NSLog(@"y == %f",randY);
            CGRect imageViewRect = CGRectMake(randX, randY, 0, 0);
            
            Animation *detailAnimation = [[Animation alloc] init];
            [detailAnimation showParabola:imageViewRect image:image showView:self.contentView];
        }
        
    }];
    
}

@end
