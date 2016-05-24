//
//  TaskTitleCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TaskTitleCell.h"

@interface TaskTitleCell()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *desc;
@property (nonatomic,strong) UILabel *award;
@end

@implementation TaskTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor redColor];
        _backView.layer.cornerRadius = 1;
        [self.contentView addSubview:_backView];
        
        _desc = [[UILabel alloc] initWithFrame:CGRectZero];
        _desc.text = @"任务描述";
        _desc.font = [UIFont systemFontOfSize:14];
        [_backView addSubview:_desc];
        
        _award = [[UILabel alloc] initWithFrame:CGRectZero];
        _award.text = @"奖励";
        _award.font = [UIFont systemFontOfSize:12];
        [_backView addSubview:_award];
    }
    return self;
}

- (void)layoutSubviews
{
    _backView.frame = CGRectMake(8,8,self.bounds.size.width-16,self.bounds.size.height-8);
    _desc.frame = CGRectMake(10,0,100,_backView.bounds.size.height);
    CGSize size = [CommonFuction sizeOfString:_award.text maxWidth:300 maxHeight:480 withFontSize:12.0f];
    _award.frame = CGRectMake(_backView.bounds.size.width -size.width-10,0,size.width,_backView.bounds.size.height);
}

+ (CGFloat)height
{
    return 40.0f;
}

@end
