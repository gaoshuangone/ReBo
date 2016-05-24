//
//  PrivateMessageVC.m
//  BoXiu
//
//  Created by andy on 15/6/19.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PrivateMessageVC.h"
#import "PrivateMessageView.h"
#import "PopupMenuDelegate.h"
#import "LiveRoomViewController.h"

@interface PrivateMessageVC ()<PopupMenuDelegate,PrivateMessageViewDelegate>
@property (nonatomic,strong) PrivateMessageView *privateView;
@property (nonatomic) NSInteger privateUnreadMessage;


@end

@implementation PrivateMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    _privateView = [[PrivateMessageView alloc] initWithFrame:CGRectZero showInView:self.rootViewController.view];
    _privateView.backgroundColor = [UIColor clearColor];
    _privateView.popupMenudelegate = self;
    _privateView.delegate = self;
    [self.view addSubview:_privateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    _privateView.backgroundColor = [UIColor clearColor];
//    _privateView.frame = CGRectMake(0, 0, self.view.frame.size.width - 90, self.view.frame.size.height - 81);
    _privateView.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.63f, self.view.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUnReadMessage];
//    if (_chatToolBar && self.rootViewController)
//    {
//        [_chatToolBar viewWillAppear];
//        if (self.baseTabMenuControl)
//        {
//            [self.rootViewController.view insertSubview:_chatToolBar aboveSubview:self.baseTabMenuControl];
//        }
//        _chatToolBar.hidden = NO;
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (_chatToolBar)
//    {
//        [_chatToolBar viewwillDisappear];
//        _chatToolBar.hidden = YES;
//    }
}

- (void)initData
{
    _privateUnreadMessage = 0;
    if (_privateView)
    {
        [_privateView clearAllMessage];
    }
}




- (void)addChatMessage:(ChatMessageModel *)chatMessageModel
{
    [self updateUnReadMessage];
    if (chatMessageModel && self.privateView)
    {
        [self.privateView addChatMessage:chatMessageModel];
    }
    else
    {
        [self.privateView addDefaultMessage];
    }
}


- (void)updateUnReadMessage
{
//    EWPTabMenuControl *tabMenuControl = (EWPTabMenuControl *)self.baseTabMenuControl;
//    if (tabMenuControl)
//    {
//        if (tabMenuControl.currentSelectedSegmentIndex != 1)
//        {
//            _privateUnreadMessage++;
//            
//        }
//        else
//        {
//            _privateUnreadMessage = 0;
//        }
//        [tabMenuControl setBadge:_privateUnreadMessage atIndex:1];
//    }
}

#pragma mark -PopupMenuDelegate
- (void)showPopupMenu:(UserInfo *)userInfo
{
    if (userInfo)
    {
        LiveRoomViewController *lr = (LiveRoomViewController *)self.rootViewController;
        if ([lr respondsToSelector:@selector(showPopupMenu:)])
        {
            [lr showPopupMenu:userInfo];
        }
    }
}

#pragma mark - PrivateViewDelegate
- (void)toLogin
{
    if (self.rootViewController)
    {
        if ([self showLoginDialog])
        {
            return;
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
