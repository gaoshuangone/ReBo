//
//  AddAttentCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AddAttentCell.h"

@implementation AddAttentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _accessoryImage.hidden=YES;
        
        _addAttend=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addAttend setTitle:@"+关注" forState:UIControlStateNormal];
        
        [_addAttend setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _addAttend.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_addAttend];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setStarInfo:(StarInfo *)starInfo
{
    [super setStarInfo:starInfo];
    
    _liveStatus.hidden = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _addAttend.frame=CGRectMake(200, 10, 80, 40);
}

- (void)OnClick:(id)sender{
    
}

@end
