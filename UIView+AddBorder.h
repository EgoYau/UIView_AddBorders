//
//  UIView+AddBorder.h
//  TancyGas
//
//  Created by EgoYau on 2017/5/19.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, BorderPosition) {
    BorderPositionTop           = 1 << 0,
    BorderPositionBottom        = 1 << 1,
    BorderPositionLeft          = 1 << 2,
    BorderPositionRight         = 1 << 3
};

@interface UIView (AddBorder)

@property(strong, nonatomic) UIColor* al_borderColor;
@property(assign, nonatomic) CGFloat al_borderWidth;
@property(assign, nonatomic) UIEdgeInsets al_insets;

- (void) addBorders:(BorderPosition) position;
- (void) addBorders:(BorderPosition) position insets:(UIEdgeInsets) insets;
- (void) addBorders:(BorderPosition) position borderColor:(UIColor*) color;
- (void) addBorders:(BorderPosition) position borderWidth:(CGFloat) borderWidth;

@end
