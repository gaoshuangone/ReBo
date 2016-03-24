//
//  ExpressionView.h
//  BoXiu
//
//  Created by andy on 14-4-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"

@class ExpressionView;
@protocol ExpressionViewDelegate <NSObject>

- (void)expressionView:(ExpressionView *)expressionView didSelectExpressionName:(NSString *)expressionName;

@end

@interface ExpressionView : BaseView
@property (nonatomic,assign) id<ExpressionViewDelegate> delegate;
@end
