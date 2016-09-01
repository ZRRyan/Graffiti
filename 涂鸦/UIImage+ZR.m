//
//  UIImage+ZR.m
//  涂鸦
//
//  Created by Ryan on 15/10/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "UIImage+ZR.h"

@implementation UIImage (ZR)
+ (instancetype)captureWithView:(UIView *)view
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    // 将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
