//
// Created by Jerry Lee on 15/1/19.
//

#import "NonArcSingleton.h"

static NonArcSingleton *sharedMyManager = nil;

@implementation NonArcSingleton

@synthesize someProperty;

#pragma mark Singleton Methods

+ (instancetype)sharedManager {
    @synchronized (self) {
        if (sharedMyManager == nil) {
            sharedMyManager = [[super allocWithZone:NULL] init];
        }
    }
    return sharedMyManager;
}

+ (instancetype)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}

- (instancetype)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [someProperty release];
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
