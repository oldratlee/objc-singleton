//
//  objc_singleton_Tests.m
//  objc-singleton-Tests
//
//  Created by Jerry Lee on 15/2/25.
//  Copyright (c) 2015年 oldratlee.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "MyManager.h"
#import "NonArcMyManager.h"

@interface SingletonSafetyTests : XCTestCase

@end

@implementation SingletonSafetyTests

#pragma mark - helper methods

- (void)p_checkSingletonOfClass:(Class)clazz usingFactorySelector:(SEL)factorySelector {
    NSString *methodName = NSStringFromSelector(factorySelector);
    XCTAssertFalse([methodName hasPrefix:@"copy"], @"Factory selector should not be a family method: %@", methodName);
    XCTAssertFalse([methodName hasPrefix:@"mutable"], @"Factory selector should not be a family method: %@", methodName);

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
    XCTAssertEqual(singleton, instance, @"Class %@ singleton safety is broken by method init", clazz);
    XCTAssertEqual(singleton, instanceByNew, @"Class %@ singleton safety is broken by method new", clazz);
}

#pragma mark - check singleton safety for class NonArcMyManager

- (void)test_sameInstanceFromFactoryMethod_NonArcMyManager {
    XCTAssertEqual([NonArcMyManager sharedManager], [NonArcMyManager sharedManager]);
}

- (void)test_checkSingletonSafety_NonArcMyManager {
    [self p_checkSingletonOfClass:[NonArcMyManager class] usingFactorySelector:@selector(sharedManager)];
}

#pragma mark - check singleton safety for class MyManager

- (void)test_sameInstanceFromFactoryMethod_MyManager {
    XCTAssertEqual([MyManager sharedManager], [MyManager sharedManager]);
}

- (void)test_checkSingletonSafety_MyManager {
    [self p_checkSingletonOfClass:[MyManager class] usingFactorySelector:@selector(sharedManager)];
}

@end
