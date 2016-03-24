//
//  BeforeLiveView.h
//  BoXiu
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UMSocialSnsService.h"
#import "UMSocial.h"

@protocol BeforeLiveViewDeleate <NSObject>

-(void)beforeLiveViewDeleateWithIndex:(NSInteger)index;

@end

@interface BeforeLiveView : BaseView
@property (strong, nonatomic) UIImageView* imageViewlLiveBG;//开始直播前，加载的初始界面
@property (strong, nonatomic) UIControl* controlTopViewPhoto;//开始直播前,在初始界面上加的拍摄封面
@property (strong, nonatomic) UIControl* controlTopViewLive;//开始直播前,在初始界面上加的可以分享的
@property (strong, nonatomic) UIControl* controlMiddleView;//开始直播前,在初始界面上加的可以分享的
@property (strong, nonatomic) UIControl* controlBeloiew;//开始直播前,在初始界面上加的可以分享的
@property (strong, nonatomic)UIButton* buttonLiving;
@property (assign, nonatomic) BOOL isSelfLivPrepareTime;//自己直播开播前准备海报阶段

@property (assign, nonatomic) id<BeforeLiveViewDeleate > deleate;
@property (strong, nonatomic) UIImagePickerController*  pickerController;
@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递


-(UIImage*)getChangedImageWithImage:(UIImage*)image withRect:(CGRect)rect;
-(void)startCaptureSession;
-(void)setQianMing:(void(^)(BOOL isNew))success failed:(void(^)(BOOL isNew))failed;
-(void)setHaiB;
- (void)viewwillDisappear;
@end
