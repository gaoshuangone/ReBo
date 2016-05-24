//
//  TaskCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TaskCell.h"

@interface TaskCell()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *desc;
@property (nonatomic,strong) UILabel *award;
@property (nonatomic,strong) UILabel *taskStatus;
@property (nonatomic,strong) UIButton *taskAction;
@end

@implementation TaskCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
//        _backView.backgroundColor = [UIColor blueColor];
        _backView.layer.cornerRadius = 1;
        [self.contentView addSubview:_backView];

        _desc = [[UILabel alloc] initWithFrame:CGRectZero];
        _desc.text = @"首次充值";
        _desc.font = [UIFont systemFontOfSize:14];
        [_backView addSubview:_desc];
        
        _award = [[UILabel alloc] initWithFrame:CGRectZero];
        _award.text = @"豪华大礼包";
        _award.font = [UIFont systemFontOfSize:12];
        [_backView addSubview:_award];
        
        _taskStatus = [[UILabel alloc] initWithFrame:CGRectZero];
        _taskStatus.text = @"未完成";
        _taskStatus.textColor = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1.0];
        _taskStatus.font = [UIFont systemFontOfSize:12];
        [_backView addSubview:_taskStatus];
        
        _taskAction = [UIButton buttonWithType:UIButtonTypeCustom];
        _taskAction.backgroundColor = [UIColor orangeColor];
        _taskAction.layer.cornerRadius = 2;
        _taskAction.titleLabel.font = [UIFont systemFontOfSize:12];
        [_taskAction setTitle:@"领取礼包" forState:UIControlStateNormal];
        [_backView addSubview:_taskAction];
    }
    return self;
}

- (void)layoutSubviews
{
    _backView.frame = CGRectMake(8,8,self.bounds.size.width,self.bounds.size.height);
    _desc.frame = CGRectMake(10,5,100,_backView.bounds.size.height-30);
    CGSize size = [CommonFuction sizeOfString:_award.text maxWidth:300 maxHeight:480 withFontSize:12.f];
    _award.frame = CGRectMake(_backView.bounds.size.width -size.width-10,5,size.width,_backView.bounds.size.height-30);
    _taskStatus.frame = CGRectMake(10,30,100,15);
    _taskAction.frame = CGRectMake(_backView.bounds.size.width -60 -10,30,60,20);
}

+ (CGFloat)height
{
    return 65.0f-16;
}

@end
