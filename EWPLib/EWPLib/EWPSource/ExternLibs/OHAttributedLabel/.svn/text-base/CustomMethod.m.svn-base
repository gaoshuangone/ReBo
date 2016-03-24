//
//  CustomMethod.m
//  MessageList
//
//  Created by 刘超 on 13-11-13.
//  Copyright (c) 2013年 刘超. All rights reserved.
//

#import "CustomMethod.h"
#import "CommonFuction.h"
#import "TMCache.h"
#import "NSString+MD5.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDWebImageDownloader.h"

@implementation CustomMethod

+ (NSString *)escapedString:(NSString *)oldString
{
    NSString *escapedString_lt = [oldString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    NSString *escapedString = [escapedString_lt stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return escapedString;
}


+ (void)drawImage:(OHAttributedLabel *)label
{
    [self drawImage:label isAlpha:YES];
}

+ (void)drawImage:(OHAttributedLabel *)label isAlpha:(BOOL)isAlpha
{
    for (NSArray *info in label.imageInfoArr)
    {
        EWPLog(@"%@",info);
        NSString *path = [info objectAtIndex:0];
        if ([path hasPrefix:@"http:"])
        {
            SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithFrame:CGRectZero];
//            if (!isAlpha)
//            {
//                imageView.backgroundColor = [UIColor whiteColor];
//            }
            CGRect frame = CGRectFromString([info objectAtIndex:2]);
            frame.origin.y += 2;
            imageView.frame = frame;
            [imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:nil];
            [label addSubview:imageView];//label内添加图片层
            [label bringSubviewToFront:imageView];
        }
        else
        {
            if (info && [info count])
            {
                if ([CommonFuction isFileExistInMainBundle:[info objectAtIndex:0]])
                {
                    NSString *filePath = [[NSBundle mainBundle] pathForResource:[info objectAtIndex:0] ofType:nil];
                    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
                    SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:data];
//                    if (!isAlpha)
//                    {
//                        imageView.backgroundColor = [UIColor whiteColor];
//                    }
                    CGRect frame = CGRectFromString([info objectAtIndex:2]);
                    frame.origin.y += 2;
                    imageView.frame = frame;
                    [imageView setImage:[UIImage imageWithData:data]];
                    [label addSubview:imageView];//label内添加图片层
                    [label bringSubviewToFront:imageView];
                }
            }
        }
        
    }
}


#pragma mark - 正则匹配电话号码，网址链接，Email地址
+ (NSArray *)addHttpArr:(NSString *)text
{
    //匹配网址链接
    NSString *regex_http = @"(https?|ftp|file)+://[^\\s]*";
    NSArray *array_http = [text componentsMatchedByRegex:regex_http];
    return array_http;
}

+ (NSArray *)addPhoneNumArr:(NSString *)text
{
    //匹配电话号码
    NSString *regex_phonenum = @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}";
    NSArray *array_phonenum = [text componentsMatchedByRegex:regex_phonenum];
    return array_phonenum;
}

+ (NSArray *)addEmailArr:(NSString *)text
{
    //匹配Email地址
    NSString *regex_email = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*";
    NSArray *array_email = [text componentsMatchedByRegex:regex_email];
    return array_email;
}

+ (NSArray *)addLocalImageArr:(NSString *)text
{
    //匹配本地图片，
    NSString *regex_localImage = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSArray *array_localImage = [text componentsMatchedByRegex:regex_localImage];
    return array_localImage;
}

+ (NSArray *)addWebImageArr:(NSString *)text
{
    //匹配网络图片
    NSString *regex_webImage = @"\\<(https?|ftp|file)+://[^\\s]*\\>";
    NSArray *array_webImage = [text componentsMatchedByRegex:regex_webImage];
    return array_webImage;
}

+ (NSArray *)addObjectArr:(NSString *)text beginFlage:(NSString *)beginFlage endFlag:(NSString *)endFlag
{
    if (!text && !beginFlage && !endFlag)
    {
        return nil;
    }
    NSString *regex = [NSString stringWithFormat:@"\\%@[a-zA-Z0-9:\\u4e00-\\u9fa5]+\\%@",beginFlage,endFlag];
    NSArray *array = [text componentsMatchedByRegex:regex];
    return array;
}

+ (NSString *)transFormStringToLocalImage:(NSString *)originalStr localImgDic:(NSDictionary *)localImgDic;
{
    //匹配表情，将表情转化为html格式
    NSString *text = originalStr;
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
    if ([array_emoji count]) {
        for (NSString *str in array_emoji) {
            NSRange range = [text rangeOfString:str];
            NSString *i_transCharacter = [localImgDic objectForKey:str];
            if (i_transCharacter)
            {
                NSString *faceImgName2x = [NSString stringWithFormat:@"%@@2x.png",[i_transCharacter substringToIndex:[i_transCharacter length] - 4]];
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='28' height='28'>",faceImgName2x];
                text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:imageHtml];
            }
        }
    }
    //返回转义后的字符串
    return text;
}

+ (NSString *)transformStringToWebImage:(NSString *)originalStr imgSize:(CGSize)imgSize
{
    //解析网络图片元素
    NSString *text = originalStr;
    NSString *regex_http = @"\\<(https?|ftp|file)+://[^\\s]*\\>";
    NSArray *array_http = [text componentsMatchedByRegex:regex_http];
    for (NSString *str in array_http)
    {
        NSRange range = [text rangeOfString:str];
        NSString *url = [text substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
        if (url)
        {
            __block CGSize size = CGSizeZero;
            if (CGSizeEqualToSize(size, imgSize))
            {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]] scale:1.3];
                size = CGSizeMake(image.size.width, image.size.height);
                if (size.height > 15)
                {
                    size.width = size.width * 15 / size.height;
                    size.height = 15;
                }
            }
            else
            {
                size = imgSize;
            }
             NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='%.1f' height='%.1f'>",url,size.width,size.height];
             text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:imageHtml];
        }
    }
    return text;
}

@end
