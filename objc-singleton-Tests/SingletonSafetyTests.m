//
//  objc_singleton_Tests.m
//  objc-singleton-Tests
//
//  Created by Jerry Lee on 15/2/25.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "ArcSingleton.h"
#import "NonArcSingleton.h"
#import "NonArcSingletonUsingGcd.h"

@interface SingletonSafetyTests : XCTestCase

@end

@implementation SingletonSafetyTests

#pragma mark - private helper methods

- (void)p_checkSingletonOfClass:(Class)clazz usingFactorySelector:(SEL)factorySelector isEqual:(BOOL)isEqual {
    NSString *methodName = NSStringFromSelector(factorySelector);
    XCTAssertFalse([methodName hasPrefix:@"copy"], @"Factory selector should not be a family method: %@", methodName);
    XCTAssertFalse([methodName hasPrefix:@"mutableCopy"], @"Factory selector should not be a family method: %@", methodName);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    // like: id singleton = [NSNull null];
    id singleton = [clazz performSelector:factorySelector];
#pragma clang diagnostic pop

    id instance = [[clazz alloc] init];
    id instanceByNew = [clazz new];

    NSLog(@"Class %@ singleton info: \n"
                    "singleton:     %@(%p)\n"
                    "instance:      %@(%p)\n"
                    "instanceByNew: %@(%p)",
            clazz,
            singleton, (__bridge void *) singleton,
            instance, (__bridge void *) instance,
            instanceByNew, (__bridge void *) instanceByNew);

    // Check singleton safety safety for method
    if (isEqual) {
        XCTAssertEqual(singleton, instance, @"Class %@ singleton safety is broken by method init", clazz);
        XCTAssertEqual(singleton, instanceByNew, @"Class %@ singleton safety is broken by method new", clazz);
    } else {
        XCTAssertNotEqual(singleton, instance, @"Class %@ singleton safety is broken by method init", clazz);
        XCTAssertNotEqual(singleton, instanceByNew, @"Class %@ singleton safety is broken by method new", clazz);
    }
}

- (void)p_checkSingletonOfClass:(Class)clazz usingFactorySelector:(SEL)factorySelector {
    [self p_checkSingletonOfClass:clazz usingFactorySelector:factorySelector isEqual:YES];
}


#pragma mark - check singleton safety for class NonArcSingleton

- (void)test_sameInstanceFromFactoryMethod_NonArcSingleton {
    XCTAssertEqual([NonArcSingleton sharedInstance], [NonArcSingleton sharedInstance]);
}

- (void)test_checkSingletonSafety_NonArcSingleton {
    [self p_checkSingletonOfClass:[NonArcSingleton class] usingFactorySelector:@selector(sharedInstance)];
}

#pragma mark - check singleton safety for class NonArcSingletonUsingGcd

- (void)test_sameInstanceFromFactoryMethod_NonArcSingletonUsingGcd {
    XCTAssertEqual([NonArcSingletonUsingGcd sharedInstance], [NonArcSingletonUsingGcd sharedInstance]);
}

- (void)test_checkSingletonSafety_NonArcSingletonUsingGcd {
    [self p_checkSingletonOfClass:[NonArcSingletonUsingGcd class] usingFactorySelector:@selector(sharedInstance)];
}

#pragma mark - check singleton safety for class ArcSingleton

- (void)test_sameInstanceFromFactoryMethod_ArcSingleton {
    XCTAssertEqual([ArcSingleton sharedInstance], [ArcSingleton sharedInstance]);
}

- (void)test_checkSingletonSafety_ArcSingleton {
#warning NOT singleton safety for method init/new! FIXME!!
    [self p_checkSingletonOfClass:[ArcSingleton class] usingFactorySelector:@selector(sharedInstance) isEqual:NO];
}

- (void)test_directInvoke_compileError {
    // __attribute__ unavailable can lead compile error of direct invocation @selector(init) of class ArcSingleton
    // __unused ArcSingleton *instance = [[ArcSingleton alloc] init];
}

@end
