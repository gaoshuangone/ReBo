//
//  EWPLable.m
//  MemberMarket
//
//  Created by andy on 13-11-27.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPLable.h"
#import <CoreText/CoreText.h>

@interface EWPLable ()
{
    float frameXOffset;
    float frameYOffset;
    
    /*字体属性*/
    CTFontRef fontRef;
    /*字体颜色*/
    CGColorRef colorRef;
    /*对齐方式*/
    CTTextAlignment alignment;
}

@property (retain,nonatomic) NSMutableAttributedString *attributeString;

@end

@implementation EWPLable

- (void)dealloc
{
   CFRelease(fontRef);
}

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentFont = [UIFont systemFontOfSize:14.0f];
        self.contentColor = [UIColor blackColor];
        self.lineSpace = 8.0f;
        self.contentAlignment = NSTextAlignmentLeft;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setContentColor:(UIColor *)contentColor
{
    _contentColor = contentColor;
    colorRef = _contentColor.CGColor;
}

- (void)setContentFont:(UIFont *)contentFont
{
    //创建字体以及字体大小
    if (fontRef)
    {
        CFRelease(fontRef);
    }
    
    fontRef = CTFontCreateWithName((CFStringRef)contentFont.fontName, contentFont.pointSize, NULL);
}

- (void)setContentAlignment:(NSTextAlignment)contentAlignment
{
    switch (contentAlignment)
    {
        case NSTextAlignmentLeft:
        {
            alignment = kCTLeftTextAlignment;
        }
            break;
        case NSTextAlignmentCenter:
        {
            alignment = kCTCenterTextAlignment;
        }
            break;
        case NSTextAlignmentRight:
        {
            alignment = kCTRightTextAlignment;
        }
            break;
        default:
        {
            alignment = kCTLeftTextAlignment;
        }
            break;
    }
}

- (void)setContent:(NSString *)content
{
    _content = content;
    if(_content && [_content length] > 0)
    {
        self.attributeString = [[NSMutableAttributedString alloc] initWithString:content];
        
        //增加字体属性
        [self.attributeString addAttribute:(id)kCTFontAttributeName
                                     value:(__bridge id)fontRef
                                     range:NSMakeRange(0, [self.attributeString length])];
        
        [self.attributeString addAttribute:(id)kCTForegroundColorAttributeName
                                     value:(__bridge id)colorRef
                                     range:NSMakeRange(0,[self.attributeString length])];

        
        //设置文本对齐方式
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
        alignmentStyle.valueSize = sizeof(alignment);
        alignmentStyle.value = &alignment;
        
        //创建文本行间距
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
        lineSpaceStyle.valueSize = sizeof(_lineSpace);
        lineSpaceStyle.value = &_lineSpace;
        
        //创建样式数组
        CTParagraphStyleSetting settings[] = {
            alignmentStyle,lineSpaceStyle
        };
        
        //设置样式
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings));
        
        //给字符串添加样式attribute
        [self.attributeString addAttribute:(id)kCTParagraphStyleAttributeName
                             value:(__bridge id)paragraphStyle
                             range:NSMakeRange(0, [self.content length])];
    }
}

- (CGFloat)heightForContentByWidth:(CGFloat)width
{
    CGFloat height = 0;
    
    if (self.attributeString)
    {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributeString);
        CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,CGSizeMake(width, CGFLOAT_MAX), NULL);
        height = size.height;
    }

    return height;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();//注，像许多低级别的API，核心文本使用的Y翻转坐标系 更杯具的是，内容是也渲染的翻转向下！
    //手动翻转,注，每次使用可将下面三句话复制粘贴过去。必用
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();//1,外边框。mac支持矩形和圆，ios仅支持矩形。本例中使用self.bounds作为path的reference
    CGPathAddRect(path, NULL, self.bounds);
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributeString);//3CTFramesetter是最重要的类时使用的绘图核心文本。管理您的字体引用和绘制文本框。就目前而言，你需要知道什么是CTFramesetterCreateWithAttributedString为您将创建一个CTFramesetter的，保留它，并使用附带的属性字符串初始化。在本节中，你有framesetter后你创建一个框架，你给CTFramesetterCreateFrame，呈现了一系列的字符串（我们选择这里的整个字符串）和矩形绘制文本时会出现。
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [self.attributeString length]), path, NULL);
    CTFrameDraw(frame, context);//4绘制
    
    CFRelease(frame);//5
    CFRelease(path);
    CFRelease(framesetter);
    
}


@end
