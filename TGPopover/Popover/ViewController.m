//
//  ViewController.m
//  Popover
//
//  Created by tangge on 16/5/8.
//  Copyright © 2016年 tangge. All rights reserved.
//

#import "ViewController.h"
#import "TGPresentController.h"
#import "PopoverAnimationManager.h"
@interface ViewController ()
/** 转场管理者 */
@property(nonatomic,strong)PopoverAnimationManager *popover;
@end

@implementation ViewController

#pragma mark - 懒加载
- (PopoverAnimationManager *)popover
{
    if (_popover == nil) {
        
        _popover = [[PopoverAnimationManager alloc] init];
        _popover.presentedViewFrame = CGRectMake(100, 50, 200, 400);
    }
    return _popover;
}

- (void)viewDidLoad {
    [super viewDidLoad];

   
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PopoverViewController" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    //设置负责自定义的转场代理
    vc.transitioningDelegate = self.popover;
    vc.modalPresentationStyle  =  UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
