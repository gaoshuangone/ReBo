//
//  PWMainView.h
//  PWProgressView
//
//  Created by Peter Willsey on 1/8/14.
//  Copyright (c) 2014 Peter Willsey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PraiseViewDelegate <NSObject>

- (void)sendApprove;

@end

@interface PraiseView : UIView

@property (nonatomic, assign) id <PraiseViewDelegate> delegate;

@property (nonatomic, assign) float progress;

@end
