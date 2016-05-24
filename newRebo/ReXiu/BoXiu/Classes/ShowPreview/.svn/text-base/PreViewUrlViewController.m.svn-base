//
//  PreViewUrlViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-30.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PreViewUrlViewController.h"

@interface PreViewUrlViewController ()

@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation PreViewUrlViewController

-(void)argumentForCanvas:(id)argumentData
{
     self.dic = (NSDictionary *)argumentData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [_dic objectForKey:@"title"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_dic objectForKey:@"mobileurl"]]]];
    [self.view addSubview:webView];
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
