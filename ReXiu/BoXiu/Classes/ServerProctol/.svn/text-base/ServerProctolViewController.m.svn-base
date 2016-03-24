//
//  ServerProctolViewController.m
//  BoXiu
//
//  Created by andy on 14-4-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ServerProctolViewController.h"
#import "MBProgressHUD.h"

@interface ServerProctolViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) MBProgressHUD *progressHud;
@end

@implementation ServerProctolViewController

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
    self.title = @"热秀服务协议";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-66)];
    webView.delegate = self;
    webView.scrollView.scrollsToTop = NO;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:PROTOCOL_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (_progressHud == nil)
    {
        _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHud];
    }
    [_progressHud show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if (_progressHud)
    {
        [_progressHud hide:YES];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
