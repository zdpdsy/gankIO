//
//  GkNavgationController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkNavgationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"

@interface GkNavgationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation GkNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationBar.barTintColor =GkColor(41, 175, 236);
    
    //设置title颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;

    
    self.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    if (self.childViewControllers.count ==0) { //根控制器
        
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
     [super pushViewController:viewController animated:animated];
}

#pragma mark - NavigationController
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;//如果是根控制器 则关闭滑动返回
    }else{
         //清空滑动返回的代理,就能实现滑动返回的功能
        self.interactivePopGestureRecognizer.delegate = nil;//开启滑动返回
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
