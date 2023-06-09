//
//  OCPrivateTool.h
//  OCStaticLibrary
//
//  Created by wesley_chen on 2023/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCPrivateTool : NSObject

+ (void)doSomethingWithVideoAtPath:(NSString *)path completion:(void (^)(BOOL success, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
