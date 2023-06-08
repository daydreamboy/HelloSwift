//
//  Test_use_Swift_class_in_OC.m
//  Test
//
//  Created by wesley_chen on 2022/4/28.
//

#import <XCTest/XCTest.h>
// Note: The file:<target name>-Swift.h should already be created automatically in your project, even if you can not see it.
#import "Test-Swift.h"

@interface Test_use_Swift_class_in_OC : XCTestCase

@end

// example: https://stackoverflow.com/a/24005242
@implementation Test_use_Swift_class_in_OC

- (void)test_MySwiftObject_someFunctionWithSomeArg {
    // Case 1
    MySwiftObject *object = [MySwiftObject new];
    NSLog(@"MyOb.someProperty: %@", object.someProperty);
    object.someProperty = @"Hello World";
    NSLog(@"MyOb.someProperty: %@", object.someProperty);

    // Case 2
    NSString *returnedString = [object someFunctionWithSomeArg:@"an arg"];
    NSLog(@"RetString: %@", returnedString);
    
    // Case 3
    //[object anotherFunction];
}

@end
