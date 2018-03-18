//
//  ViewController.m
//  MasonryMove
//
//  Created by Cerko on 2018/3/17.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "HJLayoutAndPanViewUtils.h"
#import "NSObject+KeyValueStoreUtil.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *theView;
@property (nonatomic, strong) UIView *secView;
@property (nonatomic, strong) HJLayoutAndPanViewUtils *layoutUtils;

@property (nonatomic, strong) UIButton *storeButton;
@property (nonatomic, strong) UIButton *changeButton;
@property (nonatomic, strong) UIButton *restoreButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.theView];
    [self.theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
    }];
    
    [self.view addSubview:self.secView];
    [self.secView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(self.theView.mas_bottom);
        make.centerX.equalTo(self.theView);
    }];
    
    [self.layoutUtils addView:self.theView];
    [self.layoutUtils addView:self.secView];
    
    [self.view addSubview:self.storeButton];
    [self.view addSubview:self.changeButton];
    [self.view addSubview:self.restoreButton];
    
    [self.layoutUtils addView:self.storeButton];
    [self.layoutUtils addView:self.changeButton];
    [self.layoutUtils addView:self.restoreButton];
    
    [self.storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(self.view);
        make.height.equalTo(@(100));
        make.width.equalTo(self.changeButton);
    }];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.storeButton.mas_trailing);
        make.top.bottom.with.equalTo(self.storeButton);
    }];
    [self.restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.changeButton.mas_trailing);
        make.top.bottom.width.equalTo(self.changeButton);
        make.trailing.equalTo(self.view);
    }];
}



- (UIView *)theView{
    if (!_theView) {
        _theView = [[UIView alloc] init];
        _theView.backgroundColor = [UIColor redColor];
    }
    return _theView;
}

- (UIView *)secView{
    if (!_secView) {
        _secView = [[UIView alloc] init];
        _secView.backgroundColor = [UIColor yellowColor];
    }
    return _secView;
}

- (UIButton *)storeButton{
    if (!_storeButton) {
        _storeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_storeButton setTitle:@"存储" forState:UIControlStateNormal];
        [_storeButton addTarget:self action:@selector(onClickStoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [_storeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return _storeButton;
}
- (void)onClickStoreButton:(UIButton *)sender{
    [self.changeButton jc_storeForKey:@"store" keyPaths:@[NSStringFromSelector(@selector(backgroundColor))]];
}

- (UIButton *)changeButton{
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeButton setTitle:@"修改" forState:UIControlStateNormal];
        [_changeButton addTarget:self action:@selector(onClickChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return _changeButton;
}

- (void)onClickChangeButton:(UIButton *)sender{
    
    UIColor *color = [UIColor colorWithRed:arc4random() % 255 / 255.f green:arc4random() % 255 / 255.f blue:arc4random() % 255 / 255.f alpha:1];
    sender.backgroundColor = color;
}

- (UIButton *)restoreButton{
    if (!_restoreButton) {
        _restoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_restoreButton setTitle:@"恢复" forState:UIControlStateNormal];
        [_restoreButton addTarget:self action:@selector(onClickReStoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [_restoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _restoreButton;
}

- (void)onClickReStoreButton:(UIButton *)sender{
    [self.changeButton jc_restoreForKey:@"store"];
}


- (HJLayoutAndPanViewUtils *)layoutUtils{
    if (!_layoutUtils) {
        _layoutUtils = [[HJLayoutAndPanViewUtils alloc] init];
    }
    return _layoutUtils;
}

@end
