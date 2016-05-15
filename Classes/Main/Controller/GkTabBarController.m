//
//  GkTabBarController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/14.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkTabBarController.h"

#import "GkHomeViewController.h"
#import "GkFuliController.h"
#import "GkProfileController.h"
#import "SubscribeViewController.h"
#import "GkNavgationController.h"
#import "GkTabBarView.h"

#import "UIImage+image.h"
@interface GkTabBarController ()<GkTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) GkHomeViewController *home;

@property (nonatomic, weak) GkFuliController *fuli;

@property (nonatomic, weak) GkProfileController *profile;

@end

@implementation GkTabBarController

//懒加载
-(NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
-(instancetype)initWithType:(NSString *)requestType titleName:(NSString *)titleName{
    if (requestType.length==0) {
        _requestType =@"all";
    }
    _requestType = requestType;
    _titleName  = titleName;
    if ([requestType isEqualToString:@"全部"]) {
        _requestType = @"all";
    }
    
    if (self = [super init]) {
        
    }
    return self;
}

//第一次调用这个类或者子类的时候调用
+(void)initialize
{
    //获取所有的uitabbaritem
    UITabBarItem * item  = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //设置字体颜色
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = GkColor(41, 175, 236);
    
    [item setTitleTextAttributes:att forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildController];
    [self setUpTabbar];
    // Do any additional setup after loading the view.
}

#pragma  mark - 添加所有子控制器
-(void) setUpAllChildController
{
    //干货
    GkHomeViewController * home = [[GkHomeViewController alloc] initWithType:_requestType titleName:_titleName];
    [self setUpOneChildController:home image:[UIImage imageNamed:@"Feed_Normal"] selectedImage:[UIImage imageWithOriginalName:@"Feed_Highlight"] title:_titleName];
    _home = home;
    
    
    //收藏
    SubscribeViewController * message = [[SubscribeViewController alloc] init];
    [self setUpOneChildController:message image:[UIImage imageNamed:@"Flag_Normal"] selectedImage:[UIImage imageWithOriginalName:@"Flag_Highligh"] title:@"订阅"];
    //_message = message;
    
    //福利
    GkFuliController * fuli = [[GkFuliController alloc] init];
    [self setUpOneChildController:fuli image:[UIImage imageNamed:@"Find_Normal"] selectedImage:[UIImage imageWithOriginalName:@"Find_Highlight"] title:@"福利"];
    
    //我的
    
    GkProfileController * profile = [[GkProfileController alloc] init];
    [self setUpOneChildController:profile image:[UIImage imageNamed:@"People_Normal"] selectedImage:[UIImage imageWithOriginalName:@"People_Highlight"] title:@"我"];
    _profile = profile;
}

#pragma mark - 添加一个子控制器
// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定
/**
 *  添加一个子控制器
 *
 *  @param vc            <#vc description#>
 *  @param image         <#image description#>
 *  @param selectedImage <#selectedImage description#>
 *  @param title         <#title description#>
 */
-(void) setUpOneChildController:(UIViewController *) vc image:(UIImage*) image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image =image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    GkNavgationController * nav = [[GkNavgationController alloc] initWithRootViewController:vc];
    //initWithRootViewController方法 底层会调用push方法  [self.navigationController pushViewController:one animated:YES];方法
    
    
    [self addChildViewController:nav];
    
}
#pragma mark - 设置tabbar
-(void)setUpTabbar
{
    GkTabBarView * tabbarView =[[GkTabBarView alloc] initWithFrame:self.tabBar.bounds];
    tabbarView.backgroundColor = [UIColor whiteColor];
    tabbarView.delegate = self;
    tabbarView.items= self.items;
    
    //添加到系统的tabbar
    [self.tabBar addSubview:tabbarView];
}
-(void)tabBar:(GkTabBarView *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}

#pragma mark - other

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ////删除系统的tabBarButton
    for (UIView * tabBarBtn in self.tabBar.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarBtn removeFromSuperview];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
