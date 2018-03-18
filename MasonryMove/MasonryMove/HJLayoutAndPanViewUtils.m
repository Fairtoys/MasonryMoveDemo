//
//  HJLayoutViewUtils.m
//  MasonryMove
//
//  Created by Cerko on 2018/3/17.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import "HJLayoutAndPanViewUtils.h"
#import <Masonry.h>
#import <objc/runtime.h>


void panViewUsingCenterAndSize(UIView *view, UIView *superView, CGPoint center){
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_leading).offset(center.x).priorityLow();
        make.centerY.equalTo(superView.mas_top).offset(center.y).priorityLow();
        make.size.mas_equalTo(view.frame.size);
        make.leading.greaterThanOrEqualTo(superView);
        make.top.greaterThanOrEqualTo(superView);
        make.trailing.lessThanOrEqualTo(superView);
        make.bottom.lessThanOrEqualTo(superView);
    }];
}

void translateViewWithTranslation(UIView *view, CGPoint translation){
    CGPoint center = CGPointApplyAffineTransform(view.center, CGAffineTransformMakeTranslation(translation.x, translation.y));
    UIView *superView = view.superview;
    panViewUsingCenterAndSize(view, superView, center);
}

@interface UIView (HJLayoutViewUtils)

@property (nonatomic, strong, nullable) UIPanGestureRecognizer *aPanGes;

@property (nonatomic, strong) NSArray <NSLayoutConstraint *> *lastConstraints;

- (void)saveLastConstraints;
- (void)restoreLastConstraints;

@end

@implementation UIView (HJLayoutViewUtils)

- (void)setAPanGes:(UIPanGestureRecognizer *)aPanGes{
    objc_setAssociatedObject(self, @selector(aPanGes), aPanGes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)aPanGes{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLastConstraints:(NSArray<NSLayoutConstraint *> *)lastConstraints{
    objc_setAssociatedObject(self, @selector(lastConstraints), lastConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<NSLayoutConstraint *> *)lastConstraints{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)saveLastConstraints{
    self.lastConstraints = self.constraints;
}
- (void)restoreLastConstraints{
    [self removeConstraints:self.constraints];
    [self addConstraints:self.lastConstraints];
}

@end

@interface HJLayoutAndPanViewUtils ()

@property (nonatomic, strong) NSMutableArray <UIView *> *views;

@end

@implementation HJLayoutAndPanViewUtils

- (void)addView:(UIView *)view{
    if (view.aPanGes) {
        return ;
    }
    UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    [view addGestureRecognizer:panges];
    view.aPanGes = panges;
    
    [self.views addObject:view];
}

- (void)addViews:(NSArray <UIView *> *)views{
    for (UIView *view in views) {
        [self addView:view];
    }
}

- (void)onPanGesture:(UIPanGestureRecognizer *)sender{
    
    if (UIGestureRecognizerStateBegan == sender.state) {//将其他的控件的约束全改为center和Size来约束
        if (!self.isConstrainedUsingCenterAndSize) {
            self.constrainedUsingCenterAndSize = YES;
            
            for (UIView *aView in self.views) {
                panViewUsingCenterAndSize(aView, aView.superview, aView.center);
            }
        }
    }
    UIView *view = sender.view;
    if (UIGestureRecognizerStateChanged == sender.state) {
        CGPoint translation = [sender translationInView:sender.view];
        translateViewWithTranslation(view, translation);
    }
    
    [sender setTranslation:CGPointZero inView:view];
}

- (void)removeView:(UIView *)view{
    if (view.aPanGes) {
        [view removeGestureRecognizer:view.aPanGes];
        view.aPanGes = nil;
    }
    [self.views removeObject:view];
}

- (void)removeViews:(NSArray<UIView *> *)views{
    for (UIView *view in views) {
        [self removeView:view];
    }
}

- (void)removeAll{
    NSArray <UIView *> *views = self.views.copy;
    [self removeViews:views];
}

- (NSMutableArray<UIView *> *)views{
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}


@end
