//
//  PhoneController.m
//  BoXiu
//
//  Created by tongmingyu on 15-6-11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PhoneController.h"
#import "UserInfoManager.h"

@interface PhoneController ()

@end

@implementation PhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    // Do any additional setup after loading the view.
    self.title = @"手机绑定";

    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
      
            [weakself popToCanvas:Setting_Canvas withArgument:nil];
        }
    }];

    
    int YOffset = 223;
    
    UIImageView *phone = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 196 )/2, (YOffset - 167)/2, 196 , 167)];
    [phone setImage:[UIImage imageNamed:@"Tied"]];
    [self.view addSubview:phone];
    
    UILabel *phonelabl = [[UILabel alloc] init];
    phonelabl.text = @"已绑定手机号:";
    phonelabl.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    phonelabl.font = [UIFont systemFontOfSize:14.0f];
    phonelabl.frame = CGRectMake(21, 223, 95, 15);
    [self.view addSubview:phonelabl];
    
   //将字符串中间的四个字符替换为*
    UILabel *phonenumber= [[UILabel alloc] initWithFrame:CGRectMake(21 + 95, 223, 135, 15)];
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    NSMutableString *phonenumberof = [NSMutableString stringWithFormat:@"+86 %@",userInfo.phone];
    [phonenumberof replaceCharactersInRange:NSMakeRange(7, 4) withString:@"****"];
    phonenumber.text = phonenumberof;
    phonenumber.textColor = [CommonFuction colorFromHexRGB:@"f17a4b"];
    phonenumber.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.view addSubview:phonenumber];
    
    UILabel *warnlaber = [[UILabel alloc] initWithFrame:CGRectMake(21, 512/2+3,  45, 13)];
    warnlaber.font = [UIFont systemFontOfSize:12.f];
    warnlaber.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    warnlaber.text = @"说明:";
    [self.view addSubview:warnlaber];
    
    NSString* str =@"绑定后你可以直接使用手机号登录热波间以保障账号安全。你的手机号将严格保密，不会泄露给第三方！";
    UILabel *warncontent = [[UILabel alloc] initWithFrame:CGRectMake(21, 512/2+3 +16, SCREEN_WIDTH - 21 -10 , 60)];
    warncontent.font = [UIFont systemFontOfSize:12.0f];
    warncontent.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    warncontent.numberOfLines = 0;
    
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    [warncontent setAttributedText:attributedString];
    [warncontent sizeToFit];
    warncontent.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:warncontent];
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
