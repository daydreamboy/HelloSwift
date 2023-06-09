//
//  OCPublicTool.m
//  OCStaticLibrary
//
//  Created by wesley_chen on 2023/6/9.
//

#import "OCPublicTool.h"

@implementation OCPublicTool

+ (void)doSomethingWithImageAtPath:(NSString *)path completion:(void (^)(BOOL success, NSError * _Nullable error))completion {
    NSLog(@"%@ called", NSStringFromSelector(_cmd));
    
    if (![path isKindOfClass:[NSString class]] || path.length == 0) {
        NSError *error = [NSError errorWithDomain:@"WCSomeTool" code:-1 userInfo:@{
            NSLocalizedFailureReasonErrorKey: @"path is empty",
        }];
        !completion ?: completion(NO, error);
        return;
    }
    
    !completion ?: completion(YES, nil);
}

@end
