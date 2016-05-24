//
//  IViewControllerProtocol.h
//  EWPProject
//
//  Created by jiangbin on 13-11-1.
//  Copyright (c) 2013年 woyipai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*Canvas接口*/
@class BaseViewController;

@protocol IViewControllerProtocol <NSObject>

@required
/*传递到当前视图的参数函数*/
- (void)argumentForCanvas:(id)argumentData;
@optional

/*Canvas切换接口*/
- (BaseViewController *)pushCanvas:(NSString *) canvasName withArgument:(id)argumentData;
- (BaseViewController *)popCanvasWithArgment:(id)argument;
- (BaseViewController *)popToCanvas:(NSString *) canvasName withArgument:(id)argumentData;
- (BaseViewController *)popToRootCanvasWithArgment:(id)argumentData;

//键盘监测，如果添加监测键盘，上层要根据需求实现此函数
- (void)notifyShowKeyBoard: (NSNotification*)notification;
//键盘消失会调用
- (void)notifyHideKeyBoard: (NSNotification*)notification;
@end
