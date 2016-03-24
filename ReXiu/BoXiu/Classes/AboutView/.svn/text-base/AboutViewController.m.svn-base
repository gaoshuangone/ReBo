//
//  AboutViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()


@end

@implementation AboutViewController

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
    self.title = @"关于我们";
    
    UIImageView *rexiuImg = [[UIImageView alloc] initWithFrame:CGRectMake(85, (self.view.bounds.size.height-64)/2 - 80, 58, 58)];
    [rexiuImg setImage:[UIImage imageNamed:@"reboLogo"]];
    [self.view addSubview:rexiuImg];
    
    UIImageView *vLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(155, (self.view.bounds.size.height-64)/2 - 80, 1, 60)];
    vLineImg.backgroundColor = [UIColor blackColor];
    [self.view addSubview:vLineImg];
    
    UIImageView *abountImg = [[UIImageView alloc] initWithFrame:CGRectMake(165, (self.view.bounds.size.height-64)/2 - 80, 58, 58)];
    abountImg.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:abountImg];
    
    UILabel *website = [[UILabel alloc] initWithFrame:CGRectMake(100, (self.view.bounds.size.height-64)/2 - 10, 200, 20)];
    website.text = @"www.51rebo.cn";
    website.textColor = [CommonFuction colorFromHexRGB:@"343a36"];
    website.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.view addSubview:website];
    
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(60, self.view.bounds.size.height -64 - 100, 200, 20)];
    version.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    version.font = [UIFont systemFontOfSize:14.0f];
    version.textAlignment = NSTextAlignmentCenter;
    NSString *strCurrentVersion = [NSString stringWithFormat:@"当前版本%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    version.text = strCurrentVersion;
    [self.view addSubview:version];
    
    UILabel *copyright = [[UILabel alloc] initWithFrame:CGRectMake(54, self.view.bounds.size.height -64 - 60, 230, 20)];
    copyright.text = @"杭州热秀网络技术有限公司版权所有";
    copyright.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    copyright.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:copyright];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, self.view.bounds.size.height -64 - 40, 290, 20)];
    label.text = @"Copyright©2014-2015 All Rights Reserved";
    label.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    label.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
