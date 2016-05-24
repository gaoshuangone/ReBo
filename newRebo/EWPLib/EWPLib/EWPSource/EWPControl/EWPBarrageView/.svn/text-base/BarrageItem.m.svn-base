//
//  BarrageItem.m
//  BoXiu
//
//  Created by andy on 14-12-18.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BarrageItem.h"
#import "NSAttributedString+Attributes.h"
#define Space_Of_Barrage (280)

@interface BarrageItem ()

@property (nonatomic,strong) NSMutableArray *barrageMessageLabelMArray;
@property (nonatomic,strong) dispatch_queue_t barrageItemQueue;
@property (nonatomic,strong) UIImageView *rexiuImg;
@end

@implementation BarrageItem

- (void)initView:(CGRect)frame
{
    self.textFontSize = 14.0f;
    self.backgroundColor = [UIColor clearColor];
    _barrageMessageLabelMArray = [NSMutableArray array];
    
    _rexiuImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, SCREEN_WIDTH - 14, 180)];
    _rexiuImg.layer.cornerRadius = 8.0f;
    _rexiuImg.layer.masksToBounds = YES;
    [_rexiuImg setImage:[UIImage imageNamed:@"attentionImg@2x"]];
}

- (void)addBarrageMessage:(NSString *)barrageMessage textColor:(UIColor *)textColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (barrageMessage)
        {
            CGSize size = [CommonFuction sizeOfString:barrageMessage maxWidth:1000 maxHeight:self.frame.size.height withFontSize:self.textFontSize];
            BarrageMessageLabel *barrageMessageLabel = [[BarrageMessageLabel alloc] initWithFrame:CGRectMake(self.frame.size.width, (self.frame.size.height - size.height)/2, size.width,size.height + 5)];
            barrageMessageLabel.textColor = textColor;
            barrageMessageLabel.font = [UIFont systemFontOfSize:self.textFontSize];
            
            NSRange range = [barrageMessage rangeOfString:@" "];
            
            // 设置富文本基本属性
            NSMutableAttributedString* attrStr =[[NSMutableAttributedString alloc] initWithString:barrageMessage];
            [attrStr setTextColor:[UIColor whiteColor]];
//            [attrStr setTextColor:[CommonFuction colorFromHexRGB:@"00C1B9"] range:NSMakeRange(0, range.location)];
            
            // 添加表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            // 表情图片
            attch.image = [UIImage imageNamed:@"personInfo"];
            // 设置图片大小
            attch.bounds = CGRectMake(240, 0, 32, 32);
            
            // 创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attrStr appendAttributedString:string];
            barrageMessageLabel.attributedText = attrStr;
            
            // 用label的attributedText属性来使用富文本
//            self.textLabel.attributedText = attrStr;
#pragma mark 富文本信息 url＋弹幕
//            NSString *giftUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,giveGiftModel.giftimg];
//            NSString *chatMessage = [NSString stringWithFormat:@"%@ %@ x%ld <%@>",headString, giveGiftModel.giftname, (long)giveGiftModel.objectnum,giftUrl];
//            OHAttributedLabel *label = [self creatLabelWithChatMessage:chatMessage userInfo:info isEnter:YES];
            
            
            barrageMessageLabel.fixedLocation = CGPointMake(Space_Of_Barrage, 0);
//            [barrageMessageLabel sizeToFit];
            CGRect frame = barrageMessageLabel.frame;
            frame.origin.y = 0;
            barrageMessageLabel.frame = frame;
//            barrageMessageLabel.backgroundColor = [CommonFuction colorFromHexRGB:@"f7c250"];
            
    
            
//            // 设置样式
//            NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle defaultParagraphStyle];
//            paragraphStyle.alignment = NSTextAlignmentLeft;
//            paragraphStyle.lineBreakMode = kCTLineBreakByWordWrapping;
//            paragraphStyle.firstLineHeadIndent = 0.f; // indentation for first line
//            paragraphStyle.lineSpacing = 3.f; // increase space between lines by 3 points
//            [attrStr setParagraphStyle:paragraphStyle];
//            
//            attrStr set
            
            
            
            [self addSubview:barrageMessageLabel];
            [_barrageMessageLabelMArray addObject:barrageMessageLabel];
            [barrageMessageLabel starAnimationWithRate:0.0f completion:^{
                [_barrageMessageLabelMArray removeObject:barrageMessageLabel];
                [barrageMessageLabel removeFromSuperview];
            }];
        }
    });
}

- (BOOL)commpleteStateOfBarrageItem
{
    BOOL commpleteState = YES;
    if ([_barrageMessageLabelMArray count] > 0)
    {
        commpleteState = NO;
    }
    return commpleteState;
}

- (BOOL)canAddBarrageMessage
{
    if ([_barrageMessageLabelMArray count] == 0)
    {
        return YES;
    }
    if ([_barrageMessageLabelMArray count] > 0)
    {
        BarrageMessageLabel *barrageMessageLabel = [_barrageMessageLabelMArray lastObject];
        if (barrageMessageLabel.isExceedLocation)
        {
            return YES;
        }
    }
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
