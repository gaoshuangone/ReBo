//
//  EmotionView.h
//  BoXiu
//
//  Created by andy on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "EmotionManager.h"

@class EmotionView;
@protocol EmotionViewDelegate <NSObject>

- (void)emotionView:(EmotionView *)emotionView didSelectEmotionData:(EmotionData *)emotiondata;

@end

@interface EmotionView : BaseView

@property (nonatomic,assign) id<EmotionViewDelegate> delegate;

@end
