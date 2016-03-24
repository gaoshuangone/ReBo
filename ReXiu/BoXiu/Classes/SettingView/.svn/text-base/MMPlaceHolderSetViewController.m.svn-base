//
//  MMPlaceHolderSetViewController.m
//  BoXiu
//
//  Created by andy on 16/3/14.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "MMPlaceHolderSetViewController.h"

@interface MMPlaceHolderSetViewController ()
@property (strong, nonatomic)UIColor* color;
@end

@implementation MMPlaceHolderSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.color = nil;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
   _switch1.on= [defaults boolForKey:@"MMPvisible"];
    if ([[defaults valueForKey:@"MMvisibleKindOfClasses"] isEqualToString:@"1"]||[[defaults valueForKey:@"MMvisibleKindOfClasses"] isEqualToString:@"2"]) {
        _switch2.on = YES;
    }else{
        _switch2.on = NO;
    }
    
    if ([[defaults valueForKey:@"MMvisibleKindOfClasses"] isEqualToString:@"3"]||[[defaults valueForKey:@"MMvisibleKindOfClasses"] isEqualToString:@"4"]) {
        _switch3.on = YES;
    }else{
        _switch3.on = NO;
    }
    
    
//    [defaults setBool: [MMPlaceHolderConfig defaultConfig].visible forKey:@"MMPvisible"];
//    NSString* str = nil;
//    if (_switch2.on) {
//        if (_switch3.on) {
//            str=@"1";
//        }else{
//            str = @"2";
//        }
//    }else{
//        if (_switch3.on) {
//            str=@"3";
//        }else{
//            str = @"4";
//        }
//        
//    }
//    [defaults setBool: str forKey:@"MMvisibleKindOfClasses"];
//    
//    [defaults synchronize];
    
    
//    [MMPlaceHolderConfig defaultConfig].lineWidth = 1;
//    [MMPlaceHolderConfig defaultConfig].arrowSize = 5;
//    [MMPlaceHolderConfig defaultConfig].backColor = [UIColor clearColor];
//    [MMPlaceHolderConfig defaultConfig].frameWidth = 0;
//    
//    [MMPlaceHolderConfig defaultConfig].autoDisplay = YES;
//    
//    [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor redColor];
    //using it for size debug
//    [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor blackColor];

//    [MMPlaceHolderConfig defaultConfig].visibleKindOfClasses = @[UILabel.class,UIImageView.class];
//    
//    //using it for frame debug
//    [MMPlaceHolderConfig defaultConfig].autoDisplay = YES;
//    [MMPlaceHolderConfig defaultConfig].autoDisplaySystemView = YES;
    //    [MMPlaceHolderConfig defaultConfig].showArrow = NO;
    //    [MMPlaceHolderConfig defaultConfig].showText = NO;
    
    //using it to control global visible
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)switchChange:(id)sender {
    UISwitch* swtich = sender;
    switch (swtich.tag) {
        case 1:{
    
                
            
            
            if (self.color == nil) {
                      [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor redColor];
            }
             [MMPlaceHolderConfig defaultConfig].visible = swtich.on;
        }
            
            break;
        case 2:{
            NSArray* arry = nil;
            if (swtich.on) {
                if (_switch3.on) {
                    arry = @[UIImageView.class,UILabel.class];
                }else{
                    arry = @[UIImageView.class];
                }
                
            }else{
                if (_switch3.on) {
                    arry = @[UILabel.class];
                }else{
                    arry = @[];
                }
   
            }
            
            [MMPlaceHolderConfig defaultConfig].lineWidth = 1;
            [MMPlaceHolderConfig defaultConfig].arrowSize = 5;
            [MMPlaceHolderConfig defaultConfig].backColor = [UIColor clearColor];
            [MMPlaceHolderConfig defaultConfig].frameWidth = 0;
            
            [MMPlaceHolderConfig defaultConfig].autoDisplay = YES;
            
            if (self.color == nil) {
                [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor redColor];
            }
           [MMPlaceHolderConfig defaultConfig].visibleKindOfClasses = arry;
            [MMPlaceHolderConfig defaultConfig].visible = YES;
        }
            
            break;
        case 3:{
            NSArray* arry = nil;
            if (swtich.on) {
                if (_switch2.on) {
                    arry = @[UIImageView.class,UILabel.class];
                }else{
                    arry = @[UILabel.class];
                }
                
            }else{
                if (_switch2.on) {
                    arry = @[UIImageView.class];
                }else{
                    arry = @[];
                }
                
            }
            
            [MMPlaceHolderConfig defaultConfig].lineWidth = 1;
            [MMPlaceHolderConfig defaultConfig].arrowSize = 5;
            [MMPlaceHolderConfig defaultConfig].backColor = [UIColor clearColor];
            [MMPlaceHolderConfig defaultConfig].frameWidth = 0;
            
            [MMPlaceHolderConfig defaultConfig].autoDisplay = YES;
            if (self.color == nil) {
                [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor redColor];
            }
            [MMPlaceHolderConfig defaultConfig].visibleKindOfClasses = arry;
            [MMPlaceHolderConfig defaultConfig].visible = YES;
            [MMPlaceHolderConfig defaultConfig].visibleKindOfClasses = arry;
      

        }
            
            break;
        case 4:{
            
            [MMPlaceHolderConfig defaultConfig].showArrow = swtich.on;
        }
            
            break;
        case 5:{
            [MMPlaceHolderConfig defaultConfig].autoDisplay = swtich.on;
        }
            
            break;
            
        default:
            break;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: [MMPlaceHolderConfig defaultConfig].visible forKey:@"MMPvisible"];
    NSString* str = nil;
    if (_switch2.on) {
        if (_switch3.on) {
            str=@"1";
        }else{
            str = @"2";
        }
    }else{
        if (_switch3.on) {
            str=@"3";
        }else{
            str = @"4";
        }

    }
    [defaults setValue:  str forKey:@"MMvisibleKindOfClasses"];

    [defaults synchronize];
}

- (IBAction)buttonPressed:(id)sender {
    UIButton* button =sender;
    switch (button.tag) {
        case 6:{
              [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor whiteColor];
        }
            
            break;
        case 7:{
               [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor redColor];
        }
            
            break;
        case 8:{
                [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor blackColor];
        }
            
            break;
        case 9:{
               [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor yellowColor];
        }
            
            break;
            
        default:
            break;
    }
    self.switch1.on = NO;
    [self switchChange:self.switch1];
    self.color =[MMPlaceHolderConfig defaultConfig].lineColor;
          [MMPlaceHolderConfig defaultConfig].visible = YES;
}
@end
