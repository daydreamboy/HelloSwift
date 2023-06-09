//
//  WCPublicTool.h
//  OCStaticLibrary
//
//  Created by wesley_chen on 2023/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCPublicTool : NSObject

+ (void)doSomethingWithImageAtPath:(NSString *)path completion:(void (^)(BOOL success, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
