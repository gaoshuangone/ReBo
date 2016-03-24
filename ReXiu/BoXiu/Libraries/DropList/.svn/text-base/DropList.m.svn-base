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
#define CELL_HEIGHT (22)

@interface DropList ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UILabel *selectTextLable;
@property(nonatomic,strong) UIImageView *listBtnImg;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL showList;

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
    
    self.showList = NO;
    self.maxShowCount = 6;
    _selectTextLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _selectTextLable.backgroundColor = [UIColor whiteColor];
    _selectTextLable.font = [UIFont systemFontOfSize:15.0f];
    _selectTextLable.textColor = [CommonFuction colorFromHexRGB:@"7d7d7d"];
    _selectTextLable.layer.cornerRadius = 4;
    _selectTextLable.layer.masksToBounds = YES;
    [self addSubview:_selectTextLable];
    
    int btnWidth = frame.size.height;
    _listBtnImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - btnWidth, 0, btnWidth, frame.size.height)];
    _listBtnImg.image = [UIImage imageNamed:@"arrowDown_normal.png"];
    [self addSubview:_listBtnImg];
    
    UITapGestureRecognizer *tabGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)];
    [self addGestureRecognizer:tabGestureRecognizer];
    
}

- (void)setSelectedText:(NSString *)selectedText
{
    self.selectTextLable.text = selectedText;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, tableViewFrame.origin.y - 10, self.frame.size.width,0)];
        _tableView.backgroundColor = [CommonFuction colorFromHexRGB:@"DED5CD"];
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
        frame.origin.y -= listHeight;
        frame.size.height = listHeight;
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
            _listBtnImg.image = [UIImage imageNamed:@"arrowUp_normal.png"];
            self.listBtnImg.layer.transform = CATransform3DIdentity;
        }else{
            self.listBtnImg.layer.transform = CATransform3DIdentity;
            _listBtnImg.image = [UIImage imageNamed:@"arrowDown_normal.png"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"7d7d7d"];
    }

    cell.textLabel.text = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropList:textOfRow:)])
    {
        cell.textLabel.text = [self.dataSource dropList:self textOfRow:indexPath.row];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
