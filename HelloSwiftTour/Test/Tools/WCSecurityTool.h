//
//  WCSecurityTool.h
//  Test
//
//  Created by wesley_chen on 2022/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCSecurityTool : NSObject

@end

@interface WCSecurityTool ()
+ (nullable NSData *)AES256EncryptWithData:(NSData *)data key:(NSString *)key;
+ (nullable NSData *)AES256DecryptWithData:(NSData *)data key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
