//
//  BaseTableView.m
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseTableView.h"
#import "EWPLib.h"

@interface BaseTableView()
{
    /*上拉加载*/
    MJRefreshFooterView *_footer;
    
    /*下拉刷新*/
    MJRefreshHeaderView *_header;
}
@end

@implementation BaseTableView

- (void)free
{
    if (_header)
    {
        [_header free];
    }
    
    if (_footer)
    {
        [_footer free];
    }
    
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if ([[EWPLib shareInstance] respondsToSelector:@selector(isSuccessOfInit)])
        {
            if (![[EWPLib shareInstance] isSuccessOfInit])
            {
                self = nil;
            }
        }
        else
        {
            self = nil;
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self initUI:frame];
    }
    return self;
}

- (void)initUI:(CGRect)frame
{
    self.dataSource = self;
    self.delegate = self;
    
    self.loadMore = YES;
    self.refresh = YES;
    self.curentPage = 1;
    self.totalPage = 1;
    self.backgroundColor = [UIColor clearColor];
    
    
    _tipLabel = [[UIView alloc] initWithFrame:CGRectMake((self.frameWidth -175)/2, (self.frameHeight -175)/2, 175, 175)];
    _tipLabel.backgroundColor = [UIColor clearColor];
    _tipLabel.hidden = YES;
    [self addSubview:_tipLabel];
    
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(57, 15, 115/2, 62)];
    _contentImg.image= [UIImage imageNamed:@"contentImg"];
    
    _tipLabeltext = [[UILabel alloc] initWithFrame:CGRectMake(10, 29, 100, 20)];
    _tipLabeltext.font = [UIFont systemFontOfSize:13.0f];
    _tipLabeltext.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _tipLabeltext.textAlignment = NSTextAlignmentCenter;
    _tipLabeltext.text = @"暂无数据";
    CGSize tipsize = [CommonFuction sizeOfString:_tipLabeltext.text maxWidth:80 maxHeight:14 withFontSize:13.0f];
    _tipLabeltext.frame = CGRectMake((175 - tipsize.width)/2, 93, tipsize.width, 14);
    
    _tipContent2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 62, 100, 20)];
    _tipContent2.font = [UIFont systemFontOfSize:15.0f];
    _tipContent2.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _tipContent2.textAlignment = NSTextAlignmentCenter;
    _tipContent2.text = @"下拉刷新看看～";
    CGSize tip2size = [CommonFuction sizeOfString:_tipContent2.text maxWidth:150 maxHeight:14 withFontSize:15.0f];
    _tipContent2.frame = CGRectMake((175 - tip2size.width)/2, 117, tip2size.width, 14);
    
    
    _updateView = [[UIImageView alloc] initWithFrame:CGRectMake((175 - 12)/2, 143, 12, 16)];
    _updateView.image = [UIImage imageNamed:@"update"];
    
    
    [_tipLabel addSubview:_tipLabeltext];
    [_tipLabel addSubview:_contentImg];
    [_tipLabel addSubview:_tipContent2];
    [_tipLabel addSubview:_updateView];

    
    
    
    
    
    
    
    _tipContent = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(frame) - 20) / 2, frame.size.width, 20)];
    _tipContent.textColor = [UIColor colorWithRed:154.0/255.0f green:145.0/255.0f blue:141.0/255.0f alpha:1.0];
    _tipContent.backgroundColor = [UIColor clearColor];
    _tipContent.textAlignment = NSTextAlignmentCenter;
    _tipContent.font = [UIFont systemFontOfSize:13.0f];
    _tipContent.text = nil;// NOT_HAVE_DATA;
    [self addSubview:_tipContent];
    
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 430, 115/2, 124/2)];
    [self addSubview:_contentImg];
    
    _tipContent2 = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(frame) - 20) / 2, frame.size.width, 20)];
    _tipContent2.textColor = [UIColor colorWithRed:154.0/255.0f green:145.0/255.0f blue:141.0/255.0f alpha:1.0];
    _tipContent2.backgroundColor = [UIColor clearColor];
    _tipContent2.textAlignment = NSTextAlignmentCenter;
    _tipContent2.font = [UIFont systemFontOfSize:15.0f];
    _tipContent2.text = nil;// NOT_HAVE_DATA;
    [self addSubview:_tipContent2];
    
    _updateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(frame) - 20) / 2, frame.size.width, 20)];
    [self addSubview:_updateView];
//
//    _controlNoDataView = [[UIControl alloc]initWithFrame:CGRectMake(0, (CGRectGetHeight(frame) - 110) / 2, SCREEN_WIDTH, 110)];
//    UIImageView* imageViewPhoto = [UIImageView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
  
}

#pragma mark - refresh

- (void)setLoadMore:(BOOL)loadMore
{
    _loadMore = loadMore;
    
    if (loadMore == YES)
    {
        // 上拉加载更多
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = self;
        _footer.scrollView = self;
    }
    else
    {
        _footer.scrollView = nil;
        _footer.delegate = nil;
        [_footer removeFromSuperview];
    }
}

- (void)setRefresh:(BOOL)refresh
{
    _refresh = refresh;
    if (refresh == YES)
    {
        // 下拉刷新
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.scrollView = self;
    }
    else
    {
        _header.scrollView = nil;
        _header.delegate = nil;
        [_header removeFromSuperview];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger nCount = 0;
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(numberOfSectionsInBaseTableView:)]) {
        nCount =  [self.baseDataSource numberOfSectionsInBaseTableView:self];
    }
    return nCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 让刷新控件恢复默认的状态
    if (_header)
    {
        [_header endRefreshing];
    }
    
    if (_footer)
    {
        [_footer endRefreshing];
    }
    
    NSInteger nCount = 0;
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:numberOfRowsInSection:)])
    {
        nCount = [self.baseDataSource baseTableView:(BaseTableView *)tableView numberOfRowsInSection:section];
        if (nCount > 0) {
//            _tipContent.text = @"";
        }
    }
    return nCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:cellForRowAtIndexPath:)])
    {
        return [self.baseDataSource baseTableView:(BaseTableView *)tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:canEditRowAtIndexPath:)])
    {
        return [self.baseDataSource baseTableView:(BaseTableView *)tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:commitEditingStyle:forRowAtIndexPath:)])
    {
        [self.baseDataSource baseTableView:(BaseTableView *)tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(baseTableView:titleForHeaderInSection:)])
    {
        return  [self.baseDataSource baseTableView:self titleForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - Table view delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:willSelectRowAtIndexPath:)])
    {
        return [self.baseDelegate baseTableView:(BaseTableView *)tableView willSelectRowAtIndexPath:indexPath];
    }
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:willDeselectRowAtIndexPath:)])
    {
        return [self.baseDelegate baseTableView:(BaseTableView *)tableView willDeselectRowAtIndexPath:indexPath];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)])
    {
        [self.baseDelegate baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:heightForRowAtIndexPath:)])
    {
        height = [self.baseDelegate baseTableView:(BaseTableView *)tableView heightForRowAtIndexPath:indexPath];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headheight = 0.0f;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:heightForHeaderInSection:)])
    {
        headheight = [self.baseDelegate baseTableView:(BaseTableView *)tableView heightForHeaderInSection:(section)];
    }
    
    return headheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat headheight = 0.0f;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:heightForFooterInSection:)])
    {
        headheight = [self.baseDelegate baseTableView:(BaseTableView *)tableView heightForFooterInSection:(section)];
    }
    
    return headheight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(baseTableView:viewForHeaderInSection:)])
    {
        view = [self.baseDelegate baseTableView:(BaseTableView *)tableView viewForHeaderInSection:section];
    }
    
    return view;
}


#pragma mark - MJRefreshBaseViewDelegate

- (BOOL)shouldRefresh:(MJRefreshBaseView *)refreshView
{
    BOOL bRet = YES;
    if (refreshView == _header)
    {
        bRet =  YES;
    }
    else
    {
        if (_curentPage == _totalPage)
        {
            if(self.contentOffset.y >0)
            {
                bRet = NO;
            }
            else
            {
                bRet = YES;
            }
        }
        else
        {
            bRet = YES;
        }
    }
    return bRet;
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    self.tipLabel.hidden = YES;
    
    if (_header == refreshView)
    {
        if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(refreshData)]) {
            _curentPage = 1;
            [self.baseDelegate refreshData];
        }
    }
    else
    {
        if ( _curentPage < _totalPage)
        {
            
            if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(loadMorData)]) {
                _curentPage++;
                [self.baseDelegate loadMorData];
            }
        }
        else
        {
            
            [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
            /*最后一页提示*/
            //            [self MsgBox:@"\n已经是最后一页"];
            //            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.tableView selector:@selector(reloadData) userInfo:nil repeats:NO];
        }
        
    }
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
