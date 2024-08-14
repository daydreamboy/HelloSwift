//
//  WCCommonCTool.h
//  Test
//
//  Created by wesley_chen on 2024/8/14.
//

// @see https://stackoverflow.com/questions/8133074/error-unknown-type-name-bool
#include <stdbool.h>

#pragma mark - Struct and Union

/*
 Generated swift API interface
 
 public struct Color {
     var r: Float
     var g: Float
     var b: Float

     init()
     init(r: Float, g: Float, b: Float)
 }
 */
struct Color {
    float r, g, b;
};
typedef struct Color Color;

/*
 Generated swift API interface
 
 struct SchroedingersCat {
     var isAlive: Bool { get set }
     var isDead: Bool { get set }

     init(isAlive: Bool)
     init(isDead: Bool)

     init()
 }
 */
union SchroedingersCat {
    bool isAlive;
    bool isDead;
};

#pragma mark - Unnamed Struct and Union

struct Cake {
    union {
        int layers;
        double height;
    };

    struct {
        bool icing;
        bool sprinkles;
    } toppings;
};

#pragma mark - Macro

/*
 Generated swift API interface
 
 let FADE_ANIMATION_DURATION = 0.35
 let VERSION_STRING = "2.2.10.0a"
 let MAX_RESOLUTION = 1268


 let HALF_RESOLUTION = 634
 let IS_HIGH_RES = true
 */

#define FADE_ANIMATION_DURATION 0.35
#define VERSION_STRING "2.2.10.0a"
#define MAX_RESOLUTION 1268

#define HALF_RESOLUTION (MAX_RESOLUTION / 2)
#define IS_HIGH_RES (MAX_RESOLUTION > 1024)

#pragma mark - Functions

/*
 func product(_ multiplier: Int32, _ multiplicand: Int32) -> Int32
 func quotient(_ dividend: Int32, _ divisor: Int32, _ remainder: UnsafeMutablePointer<Int32>) -> Int32

 func createPoint2D(_ x: Float, _ y: Float) -> Point2D
 func distance(_ from: Point2D, _ to: Point2D) -> Float
 */

int product(int multiplier, int multiplicand);
int quotient(int dividend, int divisor, int *remainder);

struct Point2D {
    float x;
    float y;
};
struct Point2D createPoint2D(float x, float y);
float distance(struct Point2D from, struct Point2D to);
