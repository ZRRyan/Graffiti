

//
//  ZRPainView.m
//  涂鸦
//
//  Created by Ryan on 15/10/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "ZRPainView.h"


@interface ZRPainView ()
/** Point */
//@property (nonatomic, strong) NSMutableArray *arrMTotalPoint;

/** path */
@property (nonatomic, strong) NSMutableArray *paths;
/** 起始点 */
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation ZRPainView

- (NSMutableArray *)paths
{
    if (!_paths) {
        _paths = [[NSMutableArray alloc] init];
    }
    return _paths;
}


- (void)clear
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)back
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}


/**
 * 确定起点位置
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获得当前触摸点
    UITouch *touch = [touches anyObject];
    CGPoint startPos = [touch locationInView:touch.view];
    self.startPoint = startPos;
    // 创建一个新的路径
    UIBezierPath *currentPath = [UIBezierPath bezierPath];
    // 设置起点
    [currentPath moveToPoint:startPos];
    // 添加路径到数组中
    [self.paths addObject:currentPath];
    [self setNeedsDisplay];
}


/**
 * 连线
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
        UITouch *touch = [touches anyObject];
        CGPoint currPos = [touch locationInView:touch.view];
       if (self.status == line) {
    
           UIBezierPath *currentPath = [self.paths lastObject];
           [currentPath addLineToPoint:currPos];
    
           [self setNeedsDisplay];
       } else if (self.status == rect) {
           // 画矩形
           UIBezierPath *currentPath = [self.paths lastObject];
           [currentPath removeAllPoints];
            [currentPath moveToPoint:self.startPoint];
           [currentPath addLineToPoint:CGPointMake(currPos.x, self.startPoint.y)];
           [currentPath addLineToPoint:CGPointMake(currPos.x, currPos.y)];
           [currentPath addLineToPoint:CGPointMake(self.startPoint.x, currPos.y)];
           [currentPath addLineToPoint:CGPointMake(self.startPoint.x, self.startPoint.y)];
           
           
           [self setNeedsDisplay];
       } else if (self.status == arrow) {
           UIBezierPath *currentPath = [self.paths lastObject];
           [currentPath removeAllPoints];
           [currentPath moveToPoint:self.startPoint];
           
           [currentPath addLineToPoint:currPos];
           
           // 画箭头
           [currentPath addLineToPoint:[self findLeftPointWithEndPoint:currPos]];
           
           [currentPath moveToPoint:currPos];
           [currentPath addLineToPoint:[self findRightPointWithEndPoint:currPos]];
           
           [self setNeedsDisplay];
       }
}

- (CGPoint)shapeForLineWithAngle:(float)angle length:(float)length  toPoint:(CGPoint)toPoint{
    
    float dx = cosf(angle) * length;
    float dy = sinf(angle) * length;
    CGPoint arrowEnd = CGPointMake(toPoint.x + dx, toPoint.y + dy);
    return arrowEnd;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    UITouch *touch = [touches anyObject];
//    CGPoint currPos = [touch locationInView:touch.view];
//
//    if (self.status == arrow) {
//        UIBezierPath *currentPath = [self.paths lastObject];
//        [currentPath addLineToPoint:currPos];
//
//        // 画箭头
//        [currentPath addLineToPoint:[self findLeftPointWithEndPoint:currPos]];
//
//        [currentPath moveToPoint:currPos];
//        [currentPath addLineToPoint:[self findRightPointWithEndPoint:currPos]];
//
//        [self setNeedsDisplay];
//    }
//    else if (self.status == rect) {
//        // 画矩形
//        UIBezierPath *currentPath = [self.paths lastObject];
//        [currentPath addLineToPoint:CGPointMake(currPos.x, self.startPoint.y)];
//        [currentPath addLineToPoint:CGPointMake(currPos.x, currPos.y)];
//        [currentPath addLineToPoint:CGPointMake(self.startPoint.x, currPos.y)];
//        [currentPath addLineToPoint:CGPointMake(self.startPoint.x, self.startPoint.y)];
//        [self setNeedsDisplay];
//    }
//    else if(self.status == line)
//    {
//        UIBezierPath *currentPath = [self.paths lastObject];
//        [currentPath addLineToPoint:currPos];
//        [self setNeedsDisplay];
//    }

}

- (float)findAngleWithfromPoint:(CGPoint)from toPoint:(CGPoint)to {
    
    float dy = to.y - from.y;
    float dx = to.x - from.x;
    return atan2f(dy, dx);
}


- (CGPoint)findLeftPointWithEndPoint:(CGPoint)endPoint
{
    const CGFloat arrAngle = M_PI/9;
    const CGFloat arrLength = 15;
    CGFloat angle = M_PI_2 - arrAngle - [self findAngleWithfromPoint:self.startPoint toPoint:endPoint];
    CGFloat x = endPoint.x - arrLength * sinf(angle);
    CGFloat y = endPoint.y - arrLength * cosf(angle);
    
    return CGPointMake(x, y);
}

- (CGPoint)findRightPointWithEndPoint:(CGPoint)endPoint
{
    const CGFloat arrAngle = M_PI/9;
    const CGFloat arrLength = 15;
    CGFloat angle = M_PI_2 + arrAngle - [self findAngleWithfromPoint:self.startPoint toPoint:endPoint];
    CGFloat x = endPoint.x - arrLength * sinf(angle);
    CGFloat y = endPoint.y - arrLength * cosf(angle);
    
    return CGPointMake(x, y);
}
//- (NSArray *)shapesForArrow


- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] set];
    
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}

@end
