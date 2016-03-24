//
//  LeftMenuCell.m
//  BoXiu
//
//  Created by andy on 14-8-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LeftMenuCell.h"
#import "LeftMenuButton.h"
#import "UIButton+WebCache.h"

@implementation MenuData

@end

@interface LeftMenuCell ()

@property (nonatomic,strong) LeftMenuButton *menuBtn;

@end
@implementation LeftMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        UIImage *img = [CommonFuction imageWithColor:[UIColor colorWithWhite:1 alpha:0.5] size:CGSizeMake(195, 40)];
        _menuBtn = [LeftMenuButton buttonWithType:UIButtonTypeCustom];
        [_menuBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_menuBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        
        [_menuBtn setBackgroundImage:img  forState:UIControlStateHighlighted];
        [_menuBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_menuBtn];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenuData:(MenuData *)menuData
{
    _menuData = menuData;
    [self.menuBtn setTitle:menuData.menuTitle forState:UIControlStateNormal];
    
    [self.menuBtn setImage:menuData.normalImg forState:UIControlStateNormal];

    
}

- (void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.menuBtn.frame = CGRectMake(10, 0, 195, self.frame.size.height);
}

- (void)OnClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectLeftMenu:)])
    {
        [self.delegate didSelectLeftMenu:self];
    }
}

@end
