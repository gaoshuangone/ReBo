//
//  PersonNick.m
//  BoXiu
//
//  Created by andy on 15/9/24.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PersonNick.h"
@interface PersonNick()

@property (nonatomic,strong) EWPButton *backBtn;
@property (nonatomic,strong) EWPButton *rightBtn;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *sexImgView;

@end

@implementation PersonNick
-(void)initView:(CGRect)frame{
    
    _sexImgView = [[UIImageView alloc] init];
    _sexImgView.frame = CGRectMake(0, (40-13)/2, 13, 13);
    [self addSubview:_sexImgView];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_titleLabel];
    

    
      __weak typeof(self) weakSelf = self;
    _rightBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    
    [_rightBtn setImage:[UIImage imageNamed:@"person_edit_normal"] forState:UIControlStateNormal];
//    _rightBtn.buttonBlock = ^(id sender)
//    {
//        __strong typeof(self) strongSelf = weakSelf;
//        if (strongSelf.backButtonBlock)
//        {
//            strongSelf.backButtonBlock(sender);
//        }
//    };
    
    [self addSubview:_rightBtn];
    
    UIButton* button = [CommonUtils commonButtonWithFrame:CGRectMake(30, 0, 200, 40) withTarget:self withAction:@selector(butto)];
    [self addSubview:button];
    

    
}
-(void)setIsSelfUser:(BOOL)isSelfUser{
    if (!isSelfUser) {
        _rightBtn.hidden = YES;
    }
}
-(void)butto{
    if (self.backButtonBlock)
    {
        self.backButtonBlock(0);
    }
}
-(void)setTitle:(NSString *)title{
    _title = title;
    if (title) {
        _titleLabel.text = title;
    }
    [self setNeedsLayout];
}
-(void)setSexImg:(UIImage *)sexImg{
    _sexImg  =sexImg;
    _sexImgView.image = sexImg;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
 
   
    if (_title) {
        CGSize nickSize = [CommonFuction sizeOfString:_title maxWidth:200 maxHeight:20 withFontSize:18.0f];
      
                if (_sexImg)
                {
                    _titleLabel.frame = CGRectMake(13+5, (40-nickSize.height)/2, nickSize.width, nickSize.height);
                    _rightBtn.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame)+0, (40-13)/2+1.5, 13, 13);
                }else{
                    _titleLabel.frame = CGRectMake(0, (40-nickSize.height)/2, nickSize.width, nickSize.height);
                    _rightBtn.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame)+5, (40-13)/2+1.5, 13, 13);
                }

      
        


    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
