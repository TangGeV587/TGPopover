//
//  PopoverAnimationManager.m
//  Popover
//
//  Created by tangge on 16/5/8.
//  Copyright © 2016年 tangge. All rights reserved.
//

#import "PopoverAnimationManager.h"
#import "TGPresentController.h"
@interface PopoverAnimationManager ()<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

@end
//记录当前是否是展现
static BOOL  isPesented = YES;
@implementation PopoverAnimationManager


- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    TGPresentController *presentController = [[TGPresentController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentController.presentedViewFrame = _presentedViewFrame;
    return presentController;
}

//告诉系统谁来负责转场出现
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    isPesented = YES;
    return self;
}

//告诉系统谁来负责转场消失
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    isPesented = NO;
    return self;
}

//告诉系统转场动画出现和消失要多长时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return  0.5;
}

/// 无论转场动画出现还是消失都会调用这个方法, 我们需要在这个方法中自定义转场动画的样式
// transitionContext: 上下文, 该上下文中就包含了我们需要的所有数据
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGFloat duration = [self transitionDuration:transitionContext];
    
    if (isPesented) {
        NSLog(@"出现");
        //获取被展现的View
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        //注意点: 一旦自定义转场系统就不会帮我做任何操作,包括将需要的View添加到containerView上
        [[transitionContext containerView] addSubview:toView];
        toView.layer.anchorPoint = CGPointMake(0.5, 0);
        toView.transform = CGAffineTransformMakeScale(1.0, 0.0);
        [UIView animateWithDuration:duration animations:^{
            
            toView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            //如果是自定义转场要在系统动画执行完毕后告诉系统，不然会出现一些未知错误
            [transitionContext completeTransition:YES];
        }];
    }else
    {
        NSLog(@"消失");
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        //注意:消失动画一下子不见了的原因是CGFloat不准确
        //解决方式: 只需要将Y的CGFloat值改的很小就可以了
        [UIView animateWithDuration:duration animations:^{
            
            fromView.transform = CGAffineTransformMakeScale(1.0, 0.0001);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
        }];
    }
    
    
}




@end
