//
//  GkWebViewController.m
//  gankIO
//
//  Created by 曾大鹏 on 16/3/21.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "GkWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "MBProgressHUD+MJ.h"
#import "CommonTool.h"
#import "ContentTopCell.h"
#import "GkFavDbTool.h"
#import "GkStatus.h"
#import "DKNightVersion.h"
#define kToolBarHeight 44
#define kTopHeight 44
#define kNavigationBarHeigh 44.0f

@interface GkWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,UITableViewDataSource,UITableViewDelegate,ContentTopCellDelegate>
{
     UIToolbar *toolBar;
    UIButton *favBtn;
    
    UIActivityIndicatorView *actView;
    UILabel *loadingLabel;
}


@property (nonatomic, strong) UIWebView *resultView;

@property (nonatomic, strong) UITableView *tableView;



@property (strong,nonatomic) NJKWebViewProgressView *progressView;

@property (strong,nonatomic) NJKWebViewProgress *progressProxy;

@end

@implementation GkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
     self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [self setUpAllChildView];
    [self loadDisplayView];
    //[self loadWebView];
    
}

-(void)setUpAllChildView{
    
    //头部
    [self setUpTableView];
    
    //webView
    [self setUpWebView];
    
    //底部 toolBar
    [self setUpToolBar];
    
}

- (void)loadDisplayView {
    //加载显示
    actView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actView.center= self.resultView.center;
    loadingLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.resultView.bounds.size.width, 30)];
    loadingLabel.center=CGPointMake(self.resultView.center.x, self.resultView.center.y+30);
    [loadingLabel setTextColor:[UIColor lightGrayColor]];
    [loadingLabel setFont:[UIFont systemFontOfSize:12]];
    [loadingLabel setTextAlignment:NSTextAlignmentCenter];
    [loadingLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:actView];
    [self.view addSubview:loadingLabel];
    
}
-(void)startLoading
{
    [actView startAnimating];
    [loadingLabel setText:@"正在加载..."];
    [self.view bringSubviewToFront:toolBar];
}
-(void)endLoading
{
    
    [actView stopAnimating];
    [loadingLabel removeFromSuperview];
    
}
#pragma mark - 设置tableView
-(void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
    self.tableView.bounces= NO;
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 设置toolBar
-(void)setUpToolBar
{
    float toolBarY = self.view.bounds.size.height - kToolBarHeight;
    toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, toolBarY, self.view.bounds.size.width, kToolBarHeight)];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"toolbar_bg.png"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [toolBar setTintColor:[UIColor darkGrayColor]];
    
    //分享
    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"news_toolbar_icon_share"] forState:UIControlStateNormal];
    //[shareBtn addTarget:self action:@selector(sharePost) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem=[[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    
    //navbar
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"news_toolbar_icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithCustomView:backBtn];

    
    NSString *commentStr = @"news_toolbar_icon_comment";
    UIButton *commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *commentImage = [UIImage imageNamed:commentStr];
    //[commentBtn addTarget:self action:@selector(showComment) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [commentBtn setBackgroundImage:commentImage forState:UIControlStateNormal];
    
    UIBarButtonItem *commentItem=[[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    UIBarButtonItem *blank=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:backItem,blank,commentItem,blank,shareItem, nil]];
    
    [self.view addSubview:toolBar];
}
-(void)goBack
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 设置tableView代理事件


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}
/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ContentTopCell * topCell = [ContentTopCell cellWithTableView:tableView];
        topCell.delegate = self;
        topCell.model = _status;
        topCell.isFav = _isFav;
        [topCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return topCell;
    }else{
        //webView
        static NSString *identifier = @"webViewcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            [cell.contentView addSubview:_resultView];
            [self loadWebView];
        }
        return cell;

    }
    return nil;
}
#pragma mark - ContentTopCell delegate
-(void)didFavBtnClick
{
    [GkFavDbTool UpdateFavStatus:_status];
    
}
#pragma mark - 设置WebView
-(void)setUpWebView
{
    float webViewHeith = self.view.bounds.size.height - kToolBarHeight - kTopHeight;

    
    self.resultView=[[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,webViewHeith) ];
    _resultView.scrollView.scrollEnabled = NO;
    if ([CommonTool isIOS7]) {
    }
    else
    {
        // remove shadow view when drag web view
        for (UIView *subView in [self.resultView subviews]) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                for (UIView *shadowView in [subView subviews]) {
                    if ([shadowView isKindOfClass:[UIImageView class]]) {
                        shadowView.hidden = YES;
                    }
                }
            }
        }
    }

    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //[self.view addSubview:webView];
    webView.scalesPageToFit = YES;
    self.resultView = webView;
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.resultView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)loadWebView
{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_status.url]];
    [self.resultView loadRequest:request];
}
#pragma mark - NJWebViewProgressDelegate方法
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self startLoading];
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_resultView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

//webview加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[_loadingView removeFromSuperview];
    //[MBProgressHUD hideHUD];
    [self endLoading];
}
//webview加载失败的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[_loadingView removeFromSuperview];
    //[MBProgressHUD hideHUD];
}



#pragma mark - other
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_progressView removeFromSuperview];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
