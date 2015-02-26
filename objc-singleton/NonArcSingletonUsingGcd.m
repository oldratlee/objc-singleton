//
// Created by Jerry Lee on 15/2/26.
// Copyright (c) 2015 oldratlee.com. All rights reserved.
//

#import "NonArcSingletonUsingGcd.h"

static NonArcSingletonUsingGcd *sharedMyInstance = nil;

@implementation NonArcSingletonUsingGcd

#pragma mark Singleton Methods

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[super allocWithZone:NULL] init];
    });
    return sharedMyInstance;
}

+ (instancetype)allocWithZone:(NSZone *)zone {
    return [[self sharedInstance] retain];
}

- (instancetype)init {
    if (self = [super init]) {
        _someProperty = @"Default Property Value";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [_someProperty release];
    [super dealloc];
}

- (instancetype)retain {
    return self;
}

- (NSUInteger)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}

- (oneway void)release {
    // never release
}

- (instancetype)autorelease {
    return self;
}

@end
