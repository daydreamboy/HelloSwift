//
//  Test_call_swift_function_from_static_library_in_OC.m
//  Test
//
//  Created by wesley_chen on 2023/7/30.
//

#import <XCTest/XCTest.h>

#import <SWStaticLibrary/SWStaticLibrary-Swift.h>

@interface Test_call_swift_function_from_static_library_in_OC : XCTestCase
@end

@implementation Test_call_swift_function_from_static_library_in_OC

- (void)test_call_swift_function_from_static_library_in_OC {
    [SWPublicToolForOC doSomethingWithVideoPath:@"" completion:^(BOOL success, NSError * _Nonnull error) {
        NSLog(@"success: %@, error: %@", @(success), error);
    }];
}

@end
