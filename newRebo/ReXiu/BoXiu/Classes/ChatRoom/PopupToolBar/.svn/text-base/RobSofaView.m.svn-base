//
//  RobSofaView.m
//  BoXiu
//
//  Created by andy on 14-4-17.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RobSofaView.h"
#import "SofaCell.h"
#import "SofaListModel.h"
#import "UserInfoManager.h"
#import "AppInfo.h"

@interface RobSofaView ()<SofaCellDelegate>

@end

@implementation RobSofaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initView:(CGRect)frame
{
//    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:236/255.0 blue:227/255.0 alpha:1.0];
    
    for (int nIndex = 0; nIndex < 4; nIndex++)
    {
        CGFloat sofaWidth = (frame.size.width / 4);
        SofaCell *sofaCell = [[SofaCell alloc] initWithFrame:CGRectMake(sofaWidth * nIndex, 0, sofaWidth, frame.size.height)];
        sofaCell.delegate = self;
        SofaData *sofaData = [[SofaData alloc] init];
        sofaData.sofano = nIndex + 1;
        sofaData.coin = 100;
        sofaData.num = 0;
        sofaCell.sofaData = sofaData;
        sofaCell.tag = nIndex + 1;
        [self addSubview:sofaCell];
    }
    [self initSofaList];
}

- (void)initSofaList
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    SofaListModel *model = [[SofaListModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    [model requestDataWithParams:param success:^(id object) {
        [self performSelectorOnMainThread:@selector(updateSofaData:) withObject:object waitUntilDone:NO];
    } fail:^(id object) {
        EWPLog(@"initsofalist fail");
    }];
}

- (void)updateSofaData:(id)sender
{
    SofaListModel *model = (SofaListModel *)sender;
    for (int nIndex = 0; nIndex < [model.sofaMArray count]; nIndex++)
    {
        SofaCellData *sofaCellData = [model.sofaMArray objectAtIndex:nIndex];
        SofaData *sofaData = [[SofaData alloc] init];
        sofaData.sofano = sofaCellData.sofano;
        sofaData.coin = sofaCellData.coin;
        sofaData.num = sofaCellData.num;
        sofaData.userid = sofaCellData.userid;
        sofaData.nick = sofaCellData.nick;
        sofaData.photo = sofaCellData.photo;
        sofaData.hidden = sofaCellData.hidden;
        sofaData.hiddenindex = sofaCellData.hiddenindex;
        sofaData.issupermanager = sofaCellData.issupermanager;
        
        [self setSofaData:sofaData];
    }
}

- (void)sofaCell:(SofaCell *)sofaCell sofaData:(SofaData *)sofaData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(robSofaView:sofaData:)])
    {
        [self.delegate robSofaView:self sofaData:sofaData];
    }
}

- (void)setSofaData:(SofaData *)sofaData
{
    if (sofaData)
    {
        SofaCell *sofaCell = (SofaCell *)[self viewWithTag:sofaData.sofano];
        if (sofaCell)
        {
            sofaCell.sofaData = sofaData;
        }
    }
}

//- (void)robSofa:(id)sender
//{
//    UIButton *btn = (UIButton *)sender;
//    NSLog(@"btn.tag = %d",btn.tag);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
