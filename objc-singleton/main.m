//
//  main.m
//  objc-singleton
//
//  Created by Jerry Lee on 15/1/17.
//  Copyright (c) 2015年 oldratlee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyManager.h"
#import "NonArcMyManager.h"

void checkSingletonOfClass(Class clazz, SEL factorySelector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *methodName = NSStringFromSelector(factorySelector);
    NSLog(@"=========== %@", methodName);
#ifdef DEBUG
    if ([methodName hasPrefix:@"copy"] || [methodName hasPrefix:@"mutableCopy"]) {
        [NSException raise:@"Assert Failed" format:@"Should not be a family method: %@", methodName];
    }
#endif
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

    // Check NSNull singleton safety
    if (singleton != instance || singleton != instanceByNew) {
        [NSException raise:@"Assert Failed" format:@"Class %@ singleton is broken by method init/new", clazz];
    } else {
        NSLog(@"Hurrah! Class %@ singleton is safe for method init/new!!", clazz);
    }
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        checkSingletonOfClass([NSNull class], @selector(null));
        checkSingletonOfClass([NonArcMyManager class], @selector(sharedManager));
        checkSingletonOfClass([MyManager class], @selector(sharedManager));
    }

    return 0;
}
