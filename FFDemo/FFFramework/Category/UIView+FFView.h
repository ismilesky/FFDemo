//
//  UIView+FFView.h
//  FFDemo
//
//  Created by VS on 2017/4/20.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WITH_ANIMATE                        withAnimate:(BOOL)animate;
#define FINISHED_BLOCK                      (void(^)(BOOL finished))completion
#define WITH_ANIMATE_COMPLETION             withAnimate:(BOOL)animate completion:FINISHED_BLOCK;
#define WITH_ANIMATE_DURATION_COMPLETION    withAnimate:(BOOL)animate animateDuration:(NSTimeInterval)duration completion:FINISHED_BLOCK

@interface UIView (FFView)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGSize  size;

+ (UIWindow *)keyWindow;
+ (UIScreen *)mainScreen;
+ (CGRect)mainScreenBounds;

- (void)setX:(CGFloat)x WITH_ANIMATE;
- (void)setY:(CGFloat)y WITH_ANIMATE;
- (void)setWidth:(CGFloat)width WITH_ANIMATE;
- (void)setHeight:(CGFloat)height WITH_ANIMATE;
- (void)setCenterX:(CGFloat)centerX WITH_ANIMATE;
- (void)setCenterY:(CGFloat)centerY WITH_ANIMATE;
- (void)setTop:(CGFloat)top WITH_ANIMATE;
- (void)setRight:(CGFloat)right WITH_ANIMATE;
- (void)setBottom:(CGFloat)bottom WITH_ANIMATE;
- (void)setLeft:(CGFloat)left WITH_ANIMATE;

- (void)setX:(CGFloat)x WITH_ANIMATE_COMPLETION;
- (void)setY:(CGFloat)y WITH_ANIMATE_COMPLETION;
- (void)setWidth:(CGFloat)width WITH_ANIMATE_COMPLETION;
- (void)setHeight:(CGFloat)height WITH_ANIMATE_COMPLETION;
- (void)setCenterX:(CGFloat)centerX WITH_ANIMATE_COMPLETION;
- (void)setCenterY:(CGFloat)centerY WITH_ANIMATE_COMPLETION;
- (void)setTop:(CGFloat)top WITH_ANIMATE_COMPLETION;
- (void)setRight:(CGFloat)right WITH_ANIMATE_COMPLETION;
- (void)setBottom:(CGFloat)bottom WITH_ANIMATE_COMPLETION;
- (void)setLeft:(CGFloat)left WITH_ANIMATE_COMPLETION;

- (void)setX:(CGFloat)x WITH_ANIMATE_DURATION_COMPLETION;
- (void)setY:(CGFloat)y WITH_ANIMATE_DURATION_COMPLETION;
- (void)setWidth:(CGFloat)width WITH_ANIMATE_DURATION_COMPLETION;
- (void)setHeight:(CGFloat)height WITH_ANIMATE_DURATION_COMPLETION;
- (void)setCenterX:(CGFloat)centerX WITH_ANIMATE_DURATION_COMPLETION;
- (void)setCenterY:(CGFloat)centerY WITH_ANIMATE_DURATION_COMPLETION;
- (void)setTop:(CGFloat)top WITH_ANIMATE_DURATION_COMPLETION;
- (void)setRight:(CGFloat)right WITH_ANIMATE_DURATION_COMPLETION;
- (void)setBottom:(CGFloat)bottom WITH_ANIMATE_DURATION_COMPLETION;
- (void)setLeft:(CGFloat)left WITH_ANIMATE_DURATION_COMPLETION;

#pragma mark - NewFrame
- (CGRect)newFrameWithX:(CGFloat)x;
- (CGRect)newFrameWithY:(CGFloat)y;
- (CGRect)newFrameWithWidth:(CGFloat)width;
- (CGRect)newFrameWithHeight:(CGFloat)height;
- (CGRect)newFrameWithRight:(CGFloat)right;
- (CGRect)newFrameWithBotton:(CGFloat)bottom;

#pragma mark - NewCenter
- (CGPoint)newCenterWithCenterX:(CGFloat)centerX;
- (CGPoint)newCenterWithCenterY:(CGFloat)centerY;

/*
 * 裁剪成一个圆
 */
- (void)setLayerCornerRadius;
- (void)setLayerCornerRadiusWithRadius:(CGFloat)radius;
- (void)setBorderWidth:(CGFloat)width borderColor:(CGColorRef)borderColor;
- (void)setBorderWidth:(CGFloat)width borderColor:(CGColorRef)borderColor radius:(CGFloat)radius;

/**
 *  加载xib
 */
+ (id)loadFromNib;
+ (NSString *)ClassStr;

/**
 *  RotateAnimation
 */
- (void)startRotationWithDisableViews:(NSArray *)disableViews;
- (void)rotateAnimation;
- (void)stopRotationDisableViews:(NSArray *)disableViews;

/**
 *  移除所有手势
 */
- (void)removeAllGesture;

#pragma mark - ShowAndHideView
- (void)showInViewWithZoom:(UIView *)aView;
- (void)removeWithZoomFromView:(UIView *)aView completion:(void(^)(BOOL finished))completion;
- (void)setCoverViewTouchBlock:(void(^)())coverViewTouchBlock;
- (UIView *)showViewInSuperView:(UIView *)superView withCompletedBlock:(void(^)())completedblock;
- (UIView *)showViewInSuperView:(UIView *)superView withCoverViewTouchBlock:(void(^)())touchBlock completedBlock:(void(^)())completedblock;
- (UIView *)showViewInSuperView:(UIView *)superView frame:(CGRect)frame withCoverViewBgColor:(UIColor *)bgColor alpha:(CGFloat)alpha coverViewTouchEnable:(BOOL)enable coverViewTouchBlock:(void(^)())touchBlock completedBlock:(void(^)())completedBlock;
- (void)pushInView:(UIView *)aView completion:(void(^)(BOOL finished))completion;
- (void)popFromView:(UIView *)aView completion:(void(^)(BOOL finished))completion;
- (void)setAlpha:(CGFloat)alpha isAnimation:(BOOL)isAnimation duration:(NSTimeInterval)duration completionBlock:(void(^)())completion;

#pragma mark - 绘制
/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (CAShapeLayer *)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 ** lineView:       需要绘制成虚线的view
 ** cornerRadius:   虚线拐角的弧度
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (CAShapeLayer *)drawDashedBorderAroundView:(UIView *)lineView cornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor*)lineColor;

#pragma mark - Autoresizing
- (void)setAutoresizeMaskAll;

@end
