//
//  NSString+Security.m
//  WeightCare
//
//  Created by GO on 14-7-21.
//  Copyright (c) 2014年 DreamTouch. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+Security.h"

#define gIv  @"00000000"

@implementation NSString (Security)

- (NSString *)sha1Hash {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)md5to16Hash {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}

- (NSString *)md5to32Hash {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15],result[16], result[17], result[18], result[19],
                           result[20], result[21], result[22], result[23],
                           result[24], result[25], result[26], result[27],
                           result[28], result[29], result[30], result[31]
                           ];
    return md5Result;
}

- (NSData *) tripleDesWithKey:(NSString *)key {
    
    //将密钥字符串，先MD5计算，然后生成密钥数组
    const char *cstr = [key UTF8String];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, strlen(cstr), digest);
    uint8_t keyByte[kCCKeySize3DES];
    for (int i=0; i<16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i=0; i<8; i++) {
        keyByte[16+i] = digest[i];
    }
    //将加密字符串转为字节流
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) keyByte;
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionECBMode+kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *encrpytedData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return encrpytedData;
}

/**
 *  DES加密
 */
- (NSData *) desWithKey:(NSString *)key {
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    
    Byte byte[]={0x12,0x34,0x56,0x78,0x90,0xAB,0xCD,0xEF};
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySizeDES,
                       byte,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *encrpytedData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return encrpytedData;
}

@end
