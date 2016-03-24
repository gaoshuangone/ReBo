//
//  EWPADView.h
//  MemberMarket
//
//  Created by andy on 13-11-20.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*ADblock定义 */
typedef void(^AdBlock)(int nIndex);

@interface EWPADView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong) NSArray *adImgUrlArray;
@property(nonatomic,copy) AdBlock adBlock;
@property(nonatomic,strong) UIImage *placeHolderImg;
@property(nonatomic,assign) int nCurrentPage;
@property(nonatomic,assign) int timeInterval;
/*自动循环标示*/
@property(nonatomic,assign) BOOL cycle;
@property (nonatomic,assign) BOOL hidePageControl;
/*输入参数：
 frame：大小位置；
 placeHolderImg：默认图片；
 adImgUrls:请求地址数组；
 adBlock:点击图片响应block*/
- (id)initWithFrame:(CGRect)frame placeHolderImg:(UIImage *)placeHolderImg adImgUrlArray:(NSArray *)adImgUrlArray adBlock:(AdBlock)adBlock;

@end
