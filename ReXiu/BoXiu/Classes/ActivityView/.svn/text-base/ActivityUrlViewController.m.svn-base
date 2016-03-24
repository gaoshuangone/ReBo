//
//  ActivityUrlViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ActivityUrlViewController.h"
#import "RechargeViewController.h"

@interface ActivityUrlViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) MBProgressHUD *mbProgressHud;

@end

@implementation ActivityUrlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    webView.delegate = self;
    webView.opaque = NO;
    webView.scalesPageToFit =YES;
    webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_activityUrl]]];
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)argumentForCanvas:(id)argumentData
{
    NSDictionary *dict = (NSDictionary *)argumentData;
    if(dict!=nil)
    {
        _activityUrl = [dict objectForKey:@"pageurlmobile"];
        self.title = [dict objectForKey:@"title"];
    }
    
    if(_activityUrl.length == 0)
    {
        _activityUrl = @"http://chat.51rexiu.com/";
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (_mbProgressHud == nil)
    {
        _mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_mbProgressHud];
    }
    [_mbProgressHud show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_mbProgressHud)
    {
        [_mbProgressHud hide:YES];
        _mbProgressHud = nil;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (_mbProgressHud)
    {
        [_mbProgressHud hide:YES];
        _mbProgressHud = nil;
    }
}


#pragma mark _webview上的事件

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies])
    {
//        清除缓存
//        [cookieJar deleteCookie:cookie];
        NSURLCache * cache = [NSURLCache sharedURLCache];
//        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
        EWPLog(@"%@", cookie);
    }
    
    EWPLog(@"url=%@;url.scheme=%@",request.URL,request.URL.scheme);
    // 说明协议头是ios
    if ([@"ios" isEqualToString:request.URL.scheme])
    {
        NSString *url = request.URL.absoluteString;
        NSRange range = [url rangeOfString:@":"];
        NSString *method = [request.URL.absoluteString substringFromIndex:range.location + 1];
        if ([method isEqualToString:@"recharge"])
        {
            if (![AppInfo shareInstance].bLoginSuccess)
            {
                if ([self showLoginDialog])
                {
                    return YES;
                }
            }
            else
            {
                NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
                if (hideSwitch == 1)
                {
                    [self pushCanvas:AppStore_Recharge_Canvas withArgument:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"bRootType"]];
                }
                else
                {
                    [self pushCanvas:SelectModePay_Canvas withArgument:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"bRootType"]];
                }
            }
           
        }
        else
        {
  
        }
        
        return NO;
    }
    
    return YES;
}


@end
