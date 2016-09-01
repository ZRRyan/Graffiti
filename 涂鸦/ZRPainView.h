//
//  ZRPainView.h
//  涂鸦
//
//  Created by Ryan on 15/10/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Status) {
    none,
    arrow,
    line,
    rect,
};

@interface ZRPainView : UIView
/** status */
@property (nonatomic, assign) Status status;
- (void)clear;
- (void)back;
@end
