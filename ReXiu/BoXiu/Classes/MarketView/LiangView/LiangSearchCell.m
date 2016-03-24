//
//  LiangSearchCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-9-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LiangSearchCell.h"
#import "LiangSmallCell.h"

@interface LiangSearchCell()<LiangSmallCellDelegate>

@property (nonatomic,strong) NSMutableArray *labelCellArray;

@end

@implementation LiangSearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setCellDataArray:(NSArray *)cellDataArray
{
    _cellDataArray = cellDataArray;
    if (cellDataArray && [cellDataArray count])
    {
        if (_labelCellArray == nil)
        {
            _labelCellArray = [[NSMutableArray alloc] init];
        }
        
        for (int nIndex = 0; nIndex < [_labelCellArray count]; nIndex++)
        {
            LiangSmallCell *smallCell = [self.labelCellArray objectAtIndex:nIndex];
            [smallCell removeFromSuperview];
        }
        [self.labelCellArray removeAllObjects];
        
        for (int nIndex =  0 ; nIndex < [cellDataArray count]; nIndex++)
        {
            LiangData *carData = [cellDataArray objectAtIndex:nIndex];
            
            LiangSmallCell *smallCell = [[LiangSmallCell alloc] initWithFrame:CGRectZero liangData:carData];
            smallCell.delegate = self;
            smallCell.tag = nIndex;
            [smallCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
            [self addSubview:smallCell];
            [self.labelCellArray addObject:smallCell];
        }
    }
}

- (void)OnClick:(UITapGestureRecognizer *)tapGestureRecognizer
{
    LiangSmallCell *smallCell = (LiangSmallCell *)tapGestureRecognizer.view;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didLiangIdxcodeCell:)])
    {
        LiangData *data = [self.cellDataArray objectAtIndex:smallCell.tag];
        [self.delegate didLiangIdxcodeCell:data];
    }
}

#pragma LiangSmallCellDelegate
- (void)liangSmallCell:(LiangSmallCell *)liangSmallCell buyIdxcode:(LiangData *)liangData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didLiangIdxcodeCell:)])
    {
        [self.delegate didLiangIdxcodeCell:liangData];
    }
}

+ (CGFloat)height
{
    return 123.0f;
}

- (void)layoutSubviews
{
    NSInteger nCellCount = [_labelCellArray count];
    if (nCellCount > 0)
    {
        int nWidth = self.frame.size.width/2;
        int nHeight = 123.0f;
        for (int nIndex = 0; nIndex < nCellCount; nIndex++)
        {
             LiangSmallCell *smallCell = [_labelCellArray objectAtIndex:nIndex];
            if (smallCell)
            {
                smallCell.frame = CGRectMake(nWidth * nIndex, 0, nWidth, nHeight);
            }
        }
    }
    
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

@end
