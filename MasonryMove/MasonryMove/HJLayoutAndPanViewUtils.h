//
//  HJLayoutViewUtils.h
//  MasonryMove
//
//  Created by Cerko on 2018/3/17.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


extern void panViewUsingCenterAndSize(UIView *view, UIView *superView, CGPoint center);
extern void translateViewWithTranslation(UIView *view, CGPoint translation);


@interface HJLayoutAndPanViewUtils : NSObject

@property (nonatomic, assign, getter = isConstrainedUsingCenterAndSize) BOOL constrainedUsingCenterAndSize;

- (void)addView:(UIView *)view;
- (void)addViews:(NSArray <UIView *> *)views;
- (void)removeView:(UIView *)view;
- (void)removeViews:(NSArray <UIView *> *)views;
- (void)removeAll;

@end

NS_ASSUME_NONNULL_END
