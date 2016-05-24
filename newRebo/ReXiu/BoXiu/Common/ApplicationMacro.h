//
//  ApplicationMacro.h
//  CBExtension
//
//  Created by ly on 13-7-14.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#define X(v)      ((v).frame.origin.x)
#define Y(v)      ((v).frame.origin.y)
#define WIDTH(v)  ((v).frame.size.width)
#define HEIGHT(v) ((v).frame.size.height)

#define MinX(v)   CGRectGetMinX((v).frame)
#define MinY(v)   CGRectGetMinY((v).frame)

#define MidX(v)   CGRectGetMidX((v).frame)
#define MidY(v)   CGRectGetMidY((v).frame)

#define MaxX(v)   CGRectGetMaxX((v).frame)
#define MaxY(v)   CGRectGetMaxY((v).frame)




#define CachedImage(image)   [UIImage imageNamed:(image)]
#define ImageWithPath(path)  [UIImage imageWithContentsOfFile:(path)]



#define po(obj)              CBLog(@"%@", obj)
#define pi(var_i)            CBLog(@"%d", var_i)
#define pf(var_f)            CBLog(@"%f", var_f)
#define print_function()     CBLog(@"%s", __PRETTY_FUNCTION__)




#define StrongProperty        @property (CB_STRONG, nonatomic)
#define WeakProperty          @property (CB_WEAK, nonatomic)
#define AssignProperty        @property (assign, nonatomic)