//
//  MessageCenterCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-11-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MessageCenterCell.h"
#import "UIImageView+WebCache.h"

@interface MessageCenterCell()

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *tileLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *lineImg;

@end

@implementation MessageCenterCell

-(void)setViewLine{
    UIView* view = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 64.5, SCREEN_WIDTH, 0.5)];
    view.bounds = CGRectMake(0, 64.5, SCREEN_WIDTH, 1);
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.28;
    [self.contentView addSubview:view];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 22.5;
        _headImg.userInteractionEnabled = NO;
        [self.contentView addSubview:_headImg];
        
        _tileLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tileLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _tileLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
        [self.contentView addSubview:_tileLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:10.0f];
        _timeLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _contentLabel.textColor = [CommonFuction colorFromHexRGB:@"f79350"];
        [self.contentView addSubview:_contentLabel];
        
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [self.contentView addSubview:_lineImg];
    }
    return self;
}

-(void)setMessageData:(MessageData *)messageData
{
    _messageData = messageData;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *todayTime = [formatter stringFromDate:[NSDate date]];
    NSString *yesterTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]];
    
    NSDate *today = [formatter dateFromString:todayTime];
    NSDate *yesterday = [formatter dateFromString:yesterTime];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *serversDate = [dateformatter dateFromString:messageData.time];
    
    NSString *serverTime = [formatter stringFromDate:[dateformatter dateFromString:messageData.time]];
    
    NSDate *comparServerDate = [formatter dateFromString:serverTime];
    
    if ([comparServerDate timeIntervalSinceDate:today] == 0)
    {
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *todays = [dateformatter stringFromDate:serversDate];
        EWPLog(@"今天");
        
        _timeLabel.text = [NSString stringWithFormat:@"今天  %@",todays];
    }
    else if([comparServerDate timeIntervalSinceDate:yesterday] == 0)
    {
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *timeStr = [dateformatter stringFromDate:serversDate];
        
        _timeLabel.text = [NSString stringWithFormat:@"昨天  %@",timeStr];
        EWPLog(@"昨天");
    }
    else
    {
        [dateformatter setDateFormat:@"MM月dd日  HH:mm"];
        NSString *timeStr = [dateformatter stringFromDate:serversDate];
        
        _timeLabel.text = [NSString stringWithFormat:@"%@",timeStr];
    }
    
    if (messageData.messageType == 2)
    {
        self.headImg.image = [UIImage imageNamed:@"upgrade.png"];
    }
    else
    {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:messageData.icon] placeholderImage:[UIImage imageNamed:@"right_head"]];
    }
    
    _tileLabel.text = messageData.title;
    _contentLabel.text = messageData.content;
    [self setViewLine];
}

-(void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _headImg.frame = CGRectMake(10, 10, 45, 45);
    _tileLabel.frame = CGRectMake(70, 13, 160, 20);
    _timeLabel.frame = CGRectMake(220, 13.5, 80, 20);
    _contentLabel.frame = CGRectMake(70, 38, 240, 20);
//    _lineImg.frame = CGRectMake(0, [MessageCenterCell height] - 0.5, SCREEN_WIDTH, 0.5);
//    _lineImg.frame = CGRectMake(0, [MessageCenterCell height] - 0.5, SCREEN_WIDTH, 50);
}

+(CGFloat)height
{
    return 65;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
