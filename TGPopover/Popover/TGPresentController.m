//
//  TGPresentController.m
//  Popover
//
//  Created by tangge on 16/5/8.
//  Copyright © 2016年 tangge. All rights reserved.
//

#import "TGPresentController.h"

@interface TGPresentController ()<UIGestureRecognizerDelegate>

/** 蒙板 */
@property(nonatomic,strong)UIView  *coverView;
@end


@implementation TGPresentController
#pragma mark - 懒加载
- (UIView *)coverView
{
    if (_coverView == nil) {
        
        _coverView = [[UIView alloc] initWithFrame:self.containerView.frame];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (void)tap
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
     //第一个参数:presentedViewController:  被展现的对象
    // 第二个参数:presentingViewController: 发起转场的对象(在Xcode6中系统传入的是nil, 在Xcode7中系统传入的是野指针)
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        
        NSLog(@"%@",presentedViewController);
    }
    return self;
}
/**
 *  containerView: 所有被展现的内容都放在containerView上
 *  presentedView(): 通过该方法就可以拿到被展现的视图
 */
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.presentedView.frame = _presentedViewFrame;
    [self.containerView insertSubview:self.coverView atIndex:0];
}
@end
