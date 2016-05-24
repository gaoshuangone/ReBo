//
//  EWPTitleButton.m
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPTitleButton.h"
#import "CommonFuction.h"

@interface EWPTitleButton ()

@property (nonatomic,strong) UILabel *btnTitle;
@property (nonatomic,strong) UIImageView *btnImageView;

@end

@implementation EWPTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title Image:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _fontSize = 17.0f;
        _spaceOfImageTitle = 5;
        
        _btnTitle = [[UILabel alloc] init];
        _btnTitle.text = title;
        [self addSubview:_btnTitle];
        
        _btnImageView = [[UIImageView alloc] init];
        _btnImageView.image = image;
        [self addSubview:_btnImageView];
        
    }
    return self;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.btnTitle.font = [UIFont systemFontOfSize:fontSize];
    [self setNeedsLayout];
}


- (void)setSpaceOfImageTitle:(CGFloat)spaceOfImageTitle
{
    _spaceOfImageTitle = spaceOfImageTitle;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    CGFloat imageWith = self.btnImageView.image.size.width;
    CGFloat imageHeight = self.btnImageView.image.size.height;
    
    CGSize titleSize = [CommonFuction sizeOfString:self.btnTitle.text maxWidth:300 maxHeight:480 withFontSize:self.fontSize];
    CGFloat contentWidth = imageWith > titleSize.width? imageWith : titleSize.width;
    CGFloat contentHeight = imageHeight + self.spaceOfImageTitle + titleSize.height;
    
    CGRect frame = self.frame;
    frame.size.width = frame.size.width > contentWidth ? frame.size.width : contentWidth;
    frame.size.height = frame.size.height > contentHeight ? frame.size.height :contentHeight;
    self.frame = frame;
    
    self.btnImageView.frame = CGRectMake((frame.size.width - imageWith)/2, 0, imageWith, imageHeight);
    self.btnTitle.frame = CGRectMake((frame.size.width - titleSize.width)/2, imageHeight + self.spaceOfImageTitle, titleSize.width, titleSize.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
