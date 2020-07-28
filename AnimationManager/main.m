//
//  main.m
//  AnimationManager
//
//  Created by lvzhao on 2020/7/24.
//  Copyright © 2020 吕VV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
        return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
