//
//  ViewController.m
//  AnimationManager
//
//  Created by lvzhao on 2020/7/28.
//  Copyright © 2020 吕VV. All rights reserved.
//

#import "ViewController.h"
#import "AnimationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    [[AnimationManager shareManager] showAnimation:self.view animation:AnimationTypePraise];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
 [[AnimationManager shareManager] showAnimation:self.view animation:AnimationTypeParty];

}
@end
