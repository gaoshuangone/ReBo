//
//  DropList.m
//  BoXiu
//
//  Created by andy on 14-4-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "DropList.h"
#import "AppDelegate.h"

#define LIST_BTN_WHTH (25)
#define CELL_HEIGHT (25)

@interface DropListCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *lineImg;
@property (nonatomic,assign) NSInteger margin;
@end

@implementation DropListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"e1e0e0"];
        [self.contentView addSubview:_lineImg];
    }
    return self;
}


- (void)layoutSubviews
{
    self.titleLabel.frame = CGRectMake(self.margin+5, 0, self.frame.size.width-10, self.frame.size.height - 1);
    self.lineImg.frame = CGRectMake(5, self.frame.size.height - 1, self.frame.size.width-10, 0.5);
    if (self.hideLineImg)
    {
        self.lineImg.hidden = YES;
    }
    else
    {
        self.lineImg.hidden = NO;
    }
}


@end
@interface DropList ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIImageView *backView;
@property(nonatomic,strong) UILabel *selectTextLable;
@property(nonatomic,strong) UIImageView *listBtnImg;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL showList;

@property (nonatomic,assign) NSInteger margin;
@end

@implementation DropList

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
    self.margin = 2;
    _selectTextColor = [CommonFuction colorFromHexRGB:@"575757"];
    _selectBackColor = [UIColor whiteColor];
    _listTextColor =[CommonFuction colorFromHexRGB:@"7F7A6D"];
    _listBackColor = [CommonFuction colorFromHexRGB:@"DED5CD"];
    
    _listDownArrowImg = [UIImage imageNamed:@"arrowDown_normal"];
    _listUpArrowImg = [UIImage imageNamed:@"arrowUp_normal"];
    
    self.showList = NO;
    self.maxShowCount = 6;
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    _backView.backgroundColor = _selectBackColor;
    _backView.layer.borderWidth = 0.5;
    _backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"a4a4a4"].CGColor;
    _backView.layer.cornerRadius = 3;
    [self addSubview:_backView];
    
    _selectTextLable = [[UILabel alloc] initWithFrame:CGRectMake(self.margin, 0, frame.size.width - frame.size.height - self.margin, frame.size.height)];
    _selectTextLable.backgroundColor = [UIColor clearColor];
    _selectTextLable.textAlignment = NSTextAlignmentLeft;
    _selectTextLable.font = [UIFont systemFontOfSize:13.0f];
    _selectTextLable.textColor = _selectTextColor;
    _selectTextLable.layer.masksToBounds = YES;
    [self addSubview:_selectTextLable];
    
    int btnWidth = frame.size.height;
    _listBtnImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - btnWidth, 0, btnWidth, frame.size.height)];
    _listBtnImg.image = _listDownArrowImg;
    [self addSubview:_listBtnImg];
    
    UITapGestureRecognizer *tabGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)];
    [self addGestureRecognizer:tabGestureRecognizer];
    
}

- (void)setSelectedText:(NSString *)selectedText
{
   
    self.selectTextLable.text = selectedText;
}

- (void)setSelectTextColor:(UIColor *)selectTextColor
{
    _selectTextColor = selectTextColor;
    if (_selectTextLable)
    {
        _selectTextLable.textColor = selectTextColor;
    }
}

- (void)setSelectBackColor:(UIColor *)selectBackColor
{
    _selectBackColor =  selectBackColor;
    if (_backView)
    {
        _backView.backgroundColor = selectBackColor;
    }
}

- (void)setListTextColor:(UIColor *)listTextColor
{
    _listTextColor = listTextColor;
}

- (void)setListBackColor:(UIColor *)listBackColor
{
    _listBackColor = listBackColor;
    if (_tableView)
    {
        _tableView.backgroundColor = listBackColor;
    }
}

- (void)setListDownArrowImg:(UIImage *)listDownArrowImg
{
    _listDownArrowImg = listDownArrowImg;
    if (_listBtnImg)
    {
        _listBtnImg.image = listDownArrowImg;
    }
}

- (void)setListUpArrowImg:(UIImage *)listUpArrowImg
{
    _listUpArrowImg = listUpArrowImg;
}

- (void)createTableView
{
    if (_tableView == nil)
    {
        UIControl *backControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backControl.backgroundColor = [UIColor clearColor];
        [backControl addTarget:self action:@selector(hideList:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:backControl];
        
        CGRect tableViewFrame = [self convertRect:self.frame toView:self.containerView];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x , tableViewFrame.origin.y + self.frame.size.height - 5, tableViewFrame.size.width,0)];
        _tableView.backgroundColor = _listBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        [self.containerView addSubview:_tableView];
    }
    
    if (ISBIGSYSTEM7)
    {
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
}

- (void)showList:(BOOL)show
{
    if (show)
    {
        [self createTableView];
        CGFloat listHeight = 0;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInDropList:)])
        {
            int nCount = [self.dataSource numberOfRowsInDropList:self];
            for (int nIndex = 0; nIndex < nCount; nIndex++)
            {
                if ([self.dataSource respondsToSelector:@selector(dropList:heightOfRow:)])
                {
                    listHeight += [self.dataSource dropList:self heightOfRow:nIndex];
                }
                else
                {
                    listHeight += CELL_HEIGHT;
                }
            }
        }
        if (listHeight > CELL_HEIGHT * self.maxShowCount)
        {
            listHeight = CELL_HEIGHT * self.maxShowCount;
        }
        _tableView.hidden = NO;
        CGRect frame = _tableView.frame;
        CGRect tableViewFrame = [self convertRect:self.selectTextLable.frame toView:self.containerView];
        if(tableViewFrame.origin.y + listHeight + 50> SCREEN_HEIGHT)
        {
            frame.origin.y -= self.frame.size.height;
            frame.origin.y -= listHeight;
            frame.size.height += listHeight;
        }
        else
        {
            frame.size.height += listHeight;
        }
            

        _tableView.frame = frame;
        [self rotateArrow:M_PI];
        [self.tableView reloadData];
    }
    else
    {
        _tableView.hidden = YES;
        [_tableView removeFromSuperview];
        _tableView = nil;
        [self rotateArrow:0];
    }
    self.showList = show;
}

- (void)hideList:(id)sender
{
    UIControl *backControl  = (UIControl *)sender;
    [self showList:NO];
    [backControl removeFromSuperview];
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.listBtnImg.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:^(BOOL finished){
        if(self.showList){
            _listBtnImg.image = self.listUpArrowImg;
            self.listBtnImg.layer.transform = CATransform3DIdentity;
        }else{
            self.listBtnImg.layer.transform = CATransform3DIdentity;
            _listBtnImg.image = self.listDownArrowImg;
        }
    }];
}

- (void)OnClick:(UIGestureRecognizer *)gestureRecognizer
{
    [self showList:!self.showList];
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropList:didSelectedIndex:)])
    {
        [self.delegate dropList:self didSelectedIndex:indexPath.row];
    }
    [self showList:NO];
}

#pragma mark - UITableVIewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInDropList:)])
    {
        nCount = [self.dataSource numberOfRowsInDropList:self];
    }
    return nCount;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    DropListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[DropListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.titleLabel.textColor = _listTextColor;
        cell.margin = self.margin;
    }

    cell.textLabel.text = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInDropList:)])
    {
        
        NSInteger nCount = [self.dataSource numberOfRowsInDropList:self];
        if (nCount - 1 == indexPath.row)
        {
            cell.hideLineImg = YES;
        }
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropList:textOfRow:)])
    {
        cell.titleLabel.text = [self.dataSource dropList:self textOfRow:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = CELL_HEIGHT;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropList:heightOfRow:)])
    {
        [self.dataSource dropList:self heightOfRow:indexPath.row];
    }
    return height;
}

- (void)layoutSubviews
{
    _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _selectTextLable.frame = CGRectMake(self.margin, 0, self.frame.size.width - self.frame.size.height -  self.margin, self.frame.size.height);
    _listBtnImg.frame = CGRectMake(self.frame.size.width - 10, 11, self.listDownArrowImg.size.height , self.listDownArrowImg.size.height);
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
