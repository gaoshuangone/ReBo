//
//  NSData+GTMBase64.m
//  MemberMarket
//
//  Created by andy on 13-12-3.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "NSData+GTMBase64.h"
#import "GTMBase64.h"



@implementation NSData (GTMBase64)

#define	Uint2Char(n) ((n > 9) ? ((n) + 87) : ((n) + 48))

void HEXToDSP( const char *szHex, char *szDsp, int nHexCount)
{
    int i;
    char cTemp;
    for(i = 0; i < nHexCount; i++)
    {
        cTemp = (szHex[i] & 0xf0) >> 4;
        szDsp[i * 2] = Uint2Char(cTemp);
        cTemp = szHex[i] & 0xf;
        szDsp[i * 2 + 1] = Uint2Char(cTemp);
    }
}


- (NSString *)encodeBase64Data
{
    NSData *data = [GTMBase64 encodeData:self];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)decodeBase64Data
{
    NSData * data = [GTMBase64 decodeData:self];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
-(NSString *)encodeHexToDspBase64Data
{
    const char *szHex = (const char *)[self bytes];
    int inLen = [self length];
    char szDsp[inLen*2];
    
    HEXToDSP(szHex,szDsp,inLen);
    NSString *base64String = [GTMBase64 stringByEncodingBytes:szDsp length:inLen*2];
    return base64String;
}
@end
