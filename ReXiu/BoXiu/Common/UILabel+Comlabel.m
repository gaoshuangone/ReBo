//
//  UILabel+Comlabel.m
//  BoXiu
//
//  Created by andy on 15/12/1.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "UILabel+Comlabel.h"

@implementation UILabel (Comlabel)


-(void)comSizeToFit{
    
    CGPoint point;
    point= self.center;
    [self sizeToFit];
    self.center = point;

}
-(void)comSizeToTextFit:(NSString*)textString{
    
    self.text = textString ;
    [self comSizeToFit];
 
}
-(void)setComSizeToTextFit:(NSString*)textString{
    self.text = textString ;
               
    [self comSizeToFit];
}


-(void)comFontSetCenter:(UIFont*)font{
    
    CGPoint point;
    point= self.center;
    self.font = font;
    [self sizeToFit];
    self.center = point;
    
}
@end
