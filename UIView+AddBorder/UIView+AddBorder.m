//
//  UIView+AddBorder.m
//  TancyGas
//
//  Created by EgoYau on 2017/5/19.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "UIView+AddBorder.h"
#import <objc/runtime.h>

static void *borderWidthKey     = @"UIViewAddBorder_BorderWidthKey";
static void *borderColorKey     = @"UIViewAddBorder_BorderColorKey";
static void *borderInsetsKey    = @"UIViewAddBorder_BorderInsetsKey";

@implementation UIView (AddBorder)

#pragma mark - 添加line
- (void) addSingleBorder:(BorderPosition) position{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    UIColor* borderColor = self.al_borderColor == nil ? [UIColor color10] : self.al_borderColor;
    CGFloat borderWidth = self.al_borderWidth == 0 ? 0.5 : self.al_borderWidth;
    
    CALayer* border = [CALayer layer];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = 0;
    switch (position) {
        case BorderPositionTop:
            x = self.al_insets.left;
            y = self.al_insets.top;
            w = width - self.al_insets.left - self.al_insets.right;
            h = borderWidth;
            break;
        case BorderPositionBottom:
            x = self.al_insets.left;
            y = height - self.al_insets.bottom - borderWidth;
            w = width - self.al_insets.left - self.al_insets.right;
            h = borderWidth;
            break;
        case BorderPositionLeft:
            x = self.al_insets.left;
            y = self.al_insets.top;
            w = borderWidth;
            h = height - self.al_insets.top - self.al_insets.bottom;
            break;
        case BorderPositionRight:
            x = width - self.al_insets.right - borderWidth;
            y = self.al_insets.top;
            w = borderWidth;
            h = height - self.al_insets.top - self.al_insets.bottom;
            break;
        default:
            break;
    }
    border.frame = CGRectMake(x, y, w, h);
    border.backgroundColor = borderColor.CGColor;
    [self.layer addSublayer:border];
}

- (void) addBorders:(BorderPosition) position{
    if (position & BorderPositionBottom) {
        [self addSingleBorder:BorderPositionBottom];
    }
    if (position & BorderPositionTop) {
        [self addSingleBorder:BorderPositionTop];
    }
    if (position & BorderPositionRight) {
        [self addSingleBorder:BorderPositionRight];
    }
    if (position & BorderPositionLeft) {
        [self addSingleBorder:BorderPositionLeft];
    }
}

- (void) addBorders:(BorderPosition) position insets:(UIEdgeInsets) insets{
    self.al_insets = insets;
    [self addBorders:position];
}

- (void) addBorders:(BorderPosition) position borderColor:(UIColor*) color{
    self.al_borderColor = color;
    [self addBorders:position];
}

- (void)addBorders:(BorderPosition)position borderWidth:(CGFloat)borderWidth{
    self.al_borderWidth = borderWidth;
    [self addBorders:position];
}

#pragma mark - 属性
- (void)setAl_insets:(UIEdgeInsets)al_insets{
    objc_setAssociatedObject(self, &borderInsetsKey, [NSValue valueWithUIEdgeInsets:al_insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets) al_insets{
    NSValue* value = objc_getAssociatedObject(self, &borderInsetsKey);
    UIEdgeInsets insets = [value UIEdgeInsetsValue];
    return insets;
}

- (void)setAl_borderColor:(UIColor *)al_borderColor{
    objc_setAssociatedObject(self, &borderColorKey, al_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*) al_borderColor{
    return objc_getAssociatedObject(self, &borderColorKey);
}

- (void)setAl_borderWidth:(CGFloat )al_borderWidth{
    objc_setAssociatedObject(self, &borderWidthKey, [NSString stringWithFormat:@"%f",al_borderWidth], OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)al_borderWidth{
    return [objc_getAssociatedObject(self, &borderWidthKey) floatValue];
}

@end
