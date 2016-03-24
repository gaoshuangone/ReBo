//
//  SUByteConvert.m
//  SeekU
//
//  Created by 张 艾文 on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SUByteConvert.h"

//nsstring 转为byte得倍数，utf－8为一个汉字3个byte
#define NSSTRING_TO_BYTES_MULTI 4

@implementation SUByteConvert

+ (short)byteArrayToShort:(char *)bytes {
    return ((bytes[0] & 0xFF) << 8) | (bytes[1] & 0xFF);
}

+ (void)shortToByteArray:(short)value bytes:(char *)bytes {
    
    for (int i = 0; i < 2; i++) { 
		int offset = (1 - i) * 8;
		bytes[i] = (char) ((value >> offset) & 0xff);
	}
}

+ (int)byteArrayToInt:(char *)bytes{
    return ((bytes[0] & 0xFF) << 24) + ((bytes[1] & 0xFF) << 16)
    
    + ((bytes[2] & 0xFF) << 8) + (bytes[3] & 0xFF);
}

+ (void)intToByteArray:(int)value bytes:(char *)bytes {
    
    for (int i = 0; i < 4; i++) {
		int offset = (3 - i) * 8;
		bytes[i] = (char) ((value >> offset) & 0xff);
	}
}

+ (long)byteToLong:(char *)bytes {
    long value = 0;
    int offset = 0;
    for (int i = 0; i < 8; i++) {
        int shift = (8 - 1 - i) * 8;
        value += (long) (bytes[i + offset] & 0xFF) << shift;
    }
    return value;
}


+ (int)nsstringToByteArray:(NSString *)value bytes:(char *)bytes {
    uint len;
    [value getBytes:bytes maxLength:[value length] * NSSTRING_TO_BYTES_MULTI usedLength:&len encoding:NSUTF8StringEncoding options:NSStringEncodingConversionAllowLossy range:NSMakeRange(0, [value length]) remainingRange:nil]; 
    return len;
}

+ (int)nsstringTrimmingSpacesToByteArray:(NSString *)value bytes:(char *)bytes {
    value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [self nsstringToByteArray:value bytes:bytes];
}

+ (NSString *)byteArrayToHexString:(char *)bytes len:(int)len {
    NSMutableString *str = [NSMutableString stringWithFormat:@""];
    for (int i = 0; i < len; i ++) {
        [str appendFormat:@"%02X",(unsigned char)bytes[i]];
    }
    return str;
}


@end
