//
//  main.m
//  objc-singleton
//
//  Created by Jerry Lee on 15/1/17.
//  Copyright (c) 2015年 oldratlee.com. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        // NSNull Singleton is safe for method init/new
        NSNull *nullSingleton = [NSNull null];
        NSNull *nullInstance = [[NSNull alloc] init];
        NSNull *nullInstanceByNew = [NSNull new];

        NSLog(@"NSNull Info: \n%@(%p)\n%@(%p)\n%@(%p)",
                nullSingleton, (__bridge void *) nullSingleton,
                nullInstance, (__bridge void *) nullInstance,
                nullInstanceByNew, (__bridge void *) nullInstanceByNew);

        // Check NSNull singleton safety
        if (nullSingleton != nullInstance || nullSingleton != nullInstanceByNew) {
            [NSException raise:@"Assert Failed" format:@"NSNull singleton is broken by method init/new"];
        } else {
            NSLog(@"Hurrah! NSNull singleton is safe for method init/new!!");
        }
    }

    return 0;
}

