//
//  MMPlaceHolderSetViewController.h
//  BoXiu
//
//  Created by andy on 16/3/14.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "BaseViewController.h"

@interface MMPlaceHolderSetViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;

- (IBAction)switchChange:(id)sender;

- (IBAction)buttonPressed:(id)sender;


@end
