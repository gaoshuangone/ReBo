//
//  EWPButton.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-18.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*ButtonBlock*/
typedef void(^ButtonBlock)(id sender);

/*对UIButton的扩展，如果设置了buttonBlockde 的话，原来的action将被移除*/

@interface EWPButton : UIButton

@property(nonatomic,copy) ButtonBlock buttonBlock;
@property (assign,nonatomic) BOOL isSoonCliCKLimit;

@end
