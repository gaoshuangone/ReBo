//
//  AudieceToolCell.m
//  BoXiu
//
//  Created by andy on 14-5-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AudieceToolCell.h"
#import "CommonFuction.h"

@implementation AudieceToolCellButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width - 20)/2, 30, contentRect.size.width, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = (contentRect.size.width - 30)/2;
    return CGRectMake(x, 5, 30, 30);
}

@end

@implementation AudieceToolCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)initView
{
//    self.backgroundColor = [CommonFuction colorFromHexRGB:@"d4d4d4"];
}

- (void)setShowType:(NSInteger)showType
{
    if ([self.contentView.subviews count] > 0)
    {
        return;
    }
    _showType = showType;
//    NSMutableArray *btnNormalImgs = [NSMutableArray arrayWithArray:@[@"giveGift_normal",@"chat_normal",@"kickPerson_normal",@" forbidSpeak_normal",@"report_normal"]];
//    NSMutableArray *btnSelectedImgs = [NSMutableArray arrayWithArray:@[@"giveGift_selected",@"chat_selected",@"kickPerson_selected",@" forbidSpeak_selected",@"report_select"]];
    NSMutableArray *btnName = [NSMutableArray arrayWithArray:@[@"聊天",@"送礼",@"禁言",@"踢出",@"举报"]];
//    NSMutableArray *btnName = [NSMutableArray arrayWithArray:@[@"聊天",@"送礼",@"禁言",@"踢人",@"举报"]];
    int spaceWith = 12; //17
//    if (showType == 3)
//    {
//        //showTime房间类型
//        [btnNormalImgs removeObjectAtIndex:0];
////        [btnSelectedImgs removeObjectAtIndex:0];
//        [btnName removeObjectAtIndex:0];
//        spaceWith = 35;
//    }
    //删除旧的控件
    if ([self.contentView.subviews count])
    {
        [self.contentView.subviews performSelector:@selector(removeFromSuperview)];
    }
    
    UIImage *normalImg = [CommonFuction imageWithColor:[UIColor whiteColor] size:CGSizeMake(51, 51)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f1f1f1"] size:CGSizeMake(50, 50)];
    
    for (int nIndex = 0; nIndex < [btnName count]; nIndex++)
    {
        int nCellWidth = 45;
        int nCellHeight = 40;
        
        int nX = ((nIndex % btnName.count)? nIndex : 0) * (nCellWidth + spaceWith) + 9.5;
//        int nX = ((nIndex % btnName.count)? nIndex : 0) * (nCellWidth + spaceWith) + 6;
        int nY = (nIndex / btnName.count) * (nCellHeight + 10) + 5;
        
        NSString *title = [btnName objectAtIndex:nIndex];
//        UIImage *btnNormalImg = [UIImage imageNamed:[btnNormalImgs objectAtIndex:nIndex]];
//        UIImage *btnSelectedImg = [UIImage imageNamed:[btnSelectedImgs objectAtIndex:nIndex]];
        
//        AudieceToolCellButton *btn = [AudieceToolCellButton buttonWithType:UIButtonTypeCustom];
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"a4a4a4"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTag:nIndex+100];
        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(nX, nY, nCellWidth, nCellWidth);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = nCellWidth / 2;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [CommonFuction colorFromHexRGB:@"E2E2E2"].CGColor;
        [btn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        
    }
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(77, [AudieceToolCell heightOfShowType:showType] - 0.5, 320, 0.5)];
//    lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"E2E2E2"];
    [self.contentView addSubview:lineImageView];
}

- (void)OnClick:(id)sender
{
    UIButton* button = sender;
    button.userInteractionEnabled = NO;
    [self performSelector:@selector(userInterEnabledTimer:) withObject:button afterDelay:1.5];
    
    UIButton *btn = (UIButton *)sender;
    for (int i = 0; i<=4; i++) {
        if (100+i == btn.tag) {
            [btn setBackgroundColor:[CommonFuction colorFromHexRGB:@"f1f1f1"]];

        }else {
            UIButton* button = (UIButton*)[self.contentView viewWithTag:100+i];
              [button setBackgroundColor:[UIColor clearColor]];
        }
    }
       if (self.delegate && [self.delegate respondsToSelector:@selector(audieceToolCell:didSelectIndex:)])
    {
   
        
        [self.delegate audieceToolCell:self didSelectIndex:btn.tag-100];
    }
}
-(void)userInterEnabledTimer:(UIButton*)sender{
    sender.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

+ (CGFloat)heightOfShowType:(NSInteger)showType
{
    CGFloat height = 58.0f;
//    if (showType == 3)
//    {
//        //showtime房间类型
//        height = 70.0f;
//    }
    return height;
}
@end
