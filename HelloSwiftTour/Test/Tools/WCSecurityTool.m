//
//  WCSecurityTool.m
//  Test
//
//  Created by wesley_chen on 2022/4/28.
//

#import "WCSecurityTool.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation WCSecurityTool

+ (nullable NSData *)AES256CryptWithOperation:(CCOperation)operation data:(NSData *)data key:(NSString *)key  {
    if (![data isKindOfClass:[NSData class]] || ![key isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytes = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation, kCCAlgorithmAES, kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytes);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytes];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

+ (nullable NSData *)AES256EncryptWithData:(NSData *)data key:(NSString *)key {
    return [self AES256CryptWithOperation:kCCEncrypt data:data key:key];
}

+ (nullable NSData *)AES256DecryptWithData:(NSData *)data key:(NSString *)key {
    return [self AES256CryptWithOperation:kCCDecrypt data:data key:key];
}

@end
