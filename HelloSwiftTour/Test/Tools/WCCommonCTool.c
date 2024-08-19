//
//  WCCommonCTool.c
//  Test
//
//  Created by wesley_chen on 2024/8/14.
//

#include <stdio.h>
#include <math.h>
#include <stdarg.h>

#include "WCCommonCTool.h"

#pragma mark - Functions

int product(int multiplier, int multiplicand)
{
    return multiplier * multiplicand;
}

int quotient(int dividend, int divisor, int *remainder) 
{
    int result = dividend / divisor;
    if (remainder) {
        *remainder = dividend % divisor;
    }
    return result;
}

struct Point2D createPoint2D(float x, float y) 
{
    struct Point2D p;
    p.x = x;
    p.y = y;
    
    return p;
}

float distance(struct Point2D from, struct Point2D to) {
    float dx = to.x - from.x;
    float dy = to.y - from.y;
    
    return sqrt(dx * dx + dy * dy);
}

int variadic_func1(int count, ...) {
    printf("variadic_func1 called\n");
    
    int arg;
    int sum = 0;

    va_list ap;
    va_start(ap, count);
    for (int i = 0; i < count; ++i) {
        arg = va_arg(ap, int);
        sum += arg;
    }
    va_end(ap);

    return sum;
}

int variadic_func_with_vaList(int count, va_list ap) {
    printf("variadic_func1 called\n");
    
    int arg;
    int sum = 0;
    
    for (int i = 0; i < count; ++i) {
        arg = va_arg(ap, int);
        sum += arg;
    }
    
    return sum;
}
